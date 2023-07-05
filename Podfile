# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'
['NexusDemo'].each do |target|
  target target do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
    Pod::Spec.new do |s|
      s.compiler_flags         = folly_compiler_flags + ' -Wno-nullability-completeness'
    end

    # Pods for ReactNativeClone
    pod 'hermes-engine', :podspec => "./sdks/hermes/hermes-engine.podspec"

    pod 'DoubleConversion', :podspec => "./third-party-podspecs/DoubleConversion.podspec"
    pod 'glog', :podspec => "./third-party-podspecs/glog.podspec"
    pod 'boost', :podspec => "./third-party-podspecs/boost.podspec"
    pod 'RCT-Folly', :podspec => "./third-party-podspecs/RCT-Folly.podspec", :modular_headers => true

    pod 'React-jsiexecutor', :path => "./ReactCommon/jsiexecutor"
    pod 'React-jsinspector', :path => "./ReactCommon/jsinspector"
    pod 'React-perflogger', :path => "./ReactCommon/reactperflogger"
    pod 'React-jsi', :path => "./ReactCommon/jsi"
    pod 'React-callinvoker', :path => "./ReactCommon/callinvoker"
    pod 'React-runtimeexecutor', :path => "./ReactCommon/runtimeexecutor"
    pod 'React-logger', :path => "./ReactCommon/logger"

    pod 'React-cxxreact', :path => "./ReactCommon/cxxreact"
    
    pod 'React-hermes', :path => "./ReactCommon/hermes"
  end
end
