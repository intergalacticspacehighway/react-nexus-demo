// DOMDocumentHostObject.h
#import <UIKit/UIKit.h>
#import <jsi/jsi.h>
#import <NexusDemo-Swift.h>

using namespace facebook;

class DOMElementHostObject: public jsi::HostObject {
public:
  DOMElement *element;

  DOMElementHostObject(NSString* elementType);
  
  jsi::Value get(jsi::Runtime& rt, const jsi::PropNameID& sym) override;

  void set(jsi::Runtime &, const jsi::PropNameID &name, const jsi::Value &value) override;
};
