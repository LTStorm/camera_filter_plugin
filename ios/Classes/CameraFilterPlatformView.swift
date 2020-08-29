import UIKit
import Foundation
import GPUImage
import Photos

public class CameraFilterPlatformView:NSObject,FlutterPlatformView{
    let viewId: Int64
    let channel:FlutterMethodChannel
    let messenger:FlutterBinaryMessenger
    let frame : CGRect
//////////Camera test//////////
    var camera_1 : GPUImageVideoCamera!
    var cameraView_1:GPUImageView!
    var movieWrite : GPUImageMovieWriter!
    var filter:GPUImageBilateralFilter!
    var movieURL  : URL!
    var isRecording = false

  ///////////////////////////
    init(channel:FlutterMethodChannel,
        frame: CGRect,
        viewId: Int64,
        messenger:FlutterBinaryMessenger,
        args: Any?) {
        self.viewId = viewId
        self.channel=FlutterMethodChannel(name:"camera_filter_plugin_"+String(viewId),binaryMessenger:messenger)
        self.messenger=messenger
        self.frame = frame
        super.init()
        self.setupCamera()
    }

    private func setupCamera(){
        camera_1 = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: AVCaptureDevice.Position.front)
        camera_1.horizontallyMirrorFrontFacingCamera = true
        camera_1.outputImageOrientation = UIInterfaceOrientation.portrait;
        filter = GPUImageBilateralFilter()
        cameraView_1 = GPUImageView(frame: self.frame)
        camera_1.addTarget(filter)
        filter.addTarget(cameraView_1)
        let documentDirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        debugPrint(documentDirs.path)
        movieURL = URL(string: "testmovie.mp4", relativeTo: documentDirs)
        debugPrint(movieURL.absoluteString)
        do{
        try FileManager.default.removeItem(atPath: movieURL.path)
        }
        catch{
            debugPrint(error)
        }
        self.movieWrite = GPUImageMovieWriter(movieURL: movieURL, size: CGSize(width:1080,height:1920))
        filter.addTarget(self.movieWrite)
        camera_1.startCapture()

        if(isRecording==false){
        self.movieWrite.encodingLiveVideo = true
        camera_1.audioEncodingTarget = movieWrite
        self.movieWrite.startRecording()
        isRecording=true
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+10.0, execute: {
        self.filter.removeTarget(self.movieWrite)
        self.camera_1.audioEncodingTarget=nil
        self.movieWrite.finishRecording()
        self.isRecording=false
        debugPrint("Finsish recording")
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined || status == .denied{
            PHPhotoLibrary.requestAuthorization({auth in
            if auth == .authorized{
                self.saveInPhotoLibrary()
            }else{
                debugPrint("User denied access to photo library")
            }
            })
        }else{
            self.saveInPhotoLibrary()
        }
        })

  }

  func saveInPhotoLibrary(){
    PHPhotoLibrary.shared().performChanges({
      PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.movieURL)
    }, completionHandler:{completed,error in
      if completed {
        debugPrint("save complete! path :" + self.movieURL.absoluteString)
      }else{
        debugPrint("Save failed")
      }

    })
  }


  public func view() -> UIView {
    // return videoPlayer.playerViewController.view
    return self.cameraView_1
  }
}
