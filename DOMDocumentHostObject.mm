// DOMDocumentHostObject.mm

#import <UIKit/UIKit.h>
#import "DOMDocumentHostObject.h"
#import "DOMElementHostObject.h"

using namespace facebook;

DOMDocumentHostObject::DOMDocumentHostObject(UIViewController* rootController) {
  document = [[DOMDocument alloc] initWithRootController: rootController];
}

jsi::Value DOMDocumentHostObject::get(jsi::Runtime& rt, const jsi::PropNameID& sym) {
  std::string property = sym.utf8(rt);
  if (property == "createElement") {
    return jsi::Function::createFromHostFunction(rt,
                                                 jsi::PropNameID::forAscii(rt, property),
                                                 1,
                                                 [this, &rt](jsi::Runtime& runtime,
                                                        const jsi::Value& thisValue,
                                                        const jsi::Value* arguments,
                                                        size_t count) -> jsi::Value {
      
      std::string elementType = arguments[0].asString(rt).utf8(rt);

      NSString *nsStr = [NSString stringWithUTF8String:elementType.c_str()];

      auto elementHostObject = std::make_shared<DOMElementHostObject>(nsStr);
      
      jsi::Object jsiElementHostObject = jsi::Object::createFromHostObject(rt, elementHostObject);
      
      return jsiElementHostObject;
    });
  }
  
  if (property == "appendChild") {
    return jsi::Function::createFromHostFunction(rt,
                                                 jsi::PropNameID::forAscii(rt, property),
                                                 1,
                                                 [this, &rt](jsi::Runtime& runtime,
                                                        const jsi::Value& thisValue,
                                                        const jsi::Value* arguments,
                                                        size_t count) -> jsi::Value {
      
      
      if (arguments[0].isObject()) {
        facebook::jsi::Object jsiObject = arguments[0].getObject(runtime);
        
        std::shared_ptr<jsi::HostObject> hostObjectPtr = jsiObject.getHostObject(runtime);
        
        std::shared_ptr<DOMElementHostObject> domElementHostObject = std::static_pointer_cast<DOMElementHostObject>(hostObjectPtr);
        [document appendChildWithChild: domElementHostObject->element];
        
      }
      
      return jsi::Value::undefined();
    });
  }
  
  return jsi::Value::undefined();
}

void DOMDocumentHostObject::set(jsi::Runtime& rt, const jsi::PropNameID &name, const jsi::Value &value) {
  std::string property = name.utf8(rt);

  if (property == "backgroundColor") {
    std::string color = value.asString(rt).utf8(rt);
    NSString *nsStr = [NSString stringWithUTF8String:color.c_str()];
    [document setBackgroundColorWithColor: nsStr];
  }
}
