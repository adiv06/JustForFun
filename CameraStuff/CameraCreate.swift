//
//  CameraCreate.swift
//  QuizNote
//
//  Created by Parineeta Padgilwar on 9/17/23.
//

 import Foundation
 import UIKit
 import SwiftUI
 import PhotosUI


struct PhotoLibraryCreate: UIViewControllerRepresentable {
    //@Binding var isPresented: Bool
    //An optimization would be making a state and then assinging the binding to that new state at the end so ti deosnt rerender UI every time
    @Binding var photoList: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 8
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)

        picker.modalPresentationStyle = .overCurrentContext
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoLibraryCreate

        init(parent: PhotoLibraryCreate) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.photoList.append(image)
                            }
                        }
                    }
                }
            }
            //parent.isPresented = false
        }
    }
}

 

struct CameraCreate: UIViewControllerRepresentable {
    //@Binding var isPresented: Bool
    @Binding var photoList: [UIImage]

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraVC = CameraViewController()
        cameraVC.delegate = context.coordinator
        return cameraVC
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, CameraViewControllerDelegate {
        let parent: CameraCreate
        
        init(parent: CameraCreate) {
            self.parent = parent
        }
        
        func didCapturePhoto(_ photo: UIImage) {
            //parent.isPresented = false
            parent.photoList.append(photo)
        }

        func didCancel() {
            //parent.isPresented = false
        }
    }
}

protocol CameraViewControllerDelegate: AnyObject {
    func didCapturePhoto(_ photo: UIImage)
    func didCancel()
}

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    weak var delegate: CameraViewControllerDelegate?

    private var captureSession: AVCaptureSession!
    private var photoOutput: AVCapturePhotoOutput!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    private var capturedImage: UIImage?
    private let thumbnailSize: CGSize = CGSize(width: 70, height: 70)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
        setupUI()
    }

    private func setupCameraSession() {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate?.didCancel()
            return
        }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
        } catch {
            delegate?.didCancel()
            return
        }

        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }

        captureSession.commitConfiguration()

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        //added the async so not running on main thread
        
        DispatchQueue.global(qos: .background).async{
            self.captureSession.startRunning()
        }
    }

    private func setupUI() {
        // Shutter button with custom design
        let shutterButton = UIButton(type: .custom)
        shutterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shutterButton)

        let shutterView = UIHostingController(rootView: ShutterButtonView())
        addChild(shutterView)
        shutterView.view.translatesAutoresizingMaskIntoConstraints = false
        shutterView.view.backgroundColor = .clear
        view.addSubview(shutterView.view)
        shutterView.didMove(toParent: self)

        NSLayoutConstraint.activate([
            shutterView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shutterView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        shutterView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(capturePhoto)))

        // Thumbnail button
        let thumbnailButton = UIButton(type: .custom)
        thumbnailButton.translatesAutoresizingMaskIntoConstraints = false
        thumbnailButton.layer.cornerRadius = thumbnailSize.width / 2
        thumbnailButton.clipsToBounds = true
        thumbnailButton.layer.borderWidth = 1
        thumbnailButton.layer.borderColor = UIColor.white.cgColor
        thumbnailButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(thumbnailButton)

        NSLayoutConstraint.activate([
            thumbnailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            thumbnailButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            thumbnailButton.widthAnchor.constraint(equalToConstant: thumbnailSize.width),
            thumbnailButton.heightAnchor.constraint(equalToConstant: thumbnailSize.height)
        ])

        // Done button with improved visibility
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        doneButton.layer.cornerRadius = 8
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 60),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }

    @objc private func doneTapped() {
        /*if let capturedImage = capturedImage {
            delegate?.didCapturePhoto(capturedImage)
        }*/
        dismiss(animated: true, completion: nil)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil, let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        //TextScan.cameraImages.append(image)

        if let thumbnailButton = view.subviews.first(where: { $0 is UIButton && $0.frame.size == thumbnailSize }) as? UIButton {
            withAnimation{
                thumbnailButton.setImage(image, for: .normal)
            }
            
        }
    }
}

// MARK: - ShutterButtonView

struct ShutterButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white, lineWidth: 3)
                .frame(width: 62, height: 62)
            Circle()
                .fill(Color.white)
                .frame(width: 50, height: 50)
        }
    }
}

