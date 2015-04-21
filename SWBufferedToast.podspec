Pod::Spec.new do |s|
  s.name             = "SWBufferedToast"
  s.version          = "0.1.5"
  s.summary          = "A simple UI class for presenting useful information to the user."
  s.description      = <<-DESC

                      SWBufferedToast is a simple alert-style class for presenting information to the user.
                      An SWBufferedToast can be instantiated with one of three types:
                      
                      Plain Toast
                      A simple dismissable alert with a title, description and action button.

                      Notice Toast
                      An non-dismissable alert used to notify the user of an ongoing task. This alert cannot be dismissed by the user, but can be dismissed using a timer or by calling toast.dismiss.

                      Login Toast
                      A modal login window in the style of a toast.


                      All three alert types have a buffering animation that can be turned on and off as necessary. Additionally, you can supply your own images for this buffering animation.

                      If you wish to use your own animation images for the buffering state please be sure to add them to the "Pods-SWBufferedToast-SWBufferedToast-SWBufferedToast" target.

                       DESC
  s.homepage         = "https://github.com/sfwalsh/SWBufferedToast"
  # s.screenshots     = "https://github.com/sfwalsh/SWBufferedToast/blob/master/Screenshots/plainToast.png", "https://github.com/sfwalsh/SWBufferedToast/blob/master/Screenshots/noticeToast.png", "https://github.com/sfwalsh/SWBufferedToast/blob/master/Screenshots/loginToast.png"
  s.license          = 'MIT'
  s.author           = { "Stephen Walsh" => "sw7891@hotmail.com" }
  s.source           = { :git => "https://github.com/sfwalsh/SWBufferedToast.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Hapkido_ORourke'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SWBufferedToast' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
