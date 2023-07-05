// DOMDocumentHostObject.mm

#import "DOMElementHostObject.h"

using namespace facebook;

DOMElementHostObject::DOMElementHostObject(NSString* elementType) {
  auto element = [[DOMElement alloc] initWithType: elementType];
  this->element = element;
}

jsi::Value DOMElementHostObject::get(jsi::Runtime& rt, const jsi::PropNameID& sym) {
  std::string property = sym.utf8(rt);
  if (property == "appendChild") {
    return jsi::Function::createFromHostFunction(rt,
                                                 jsi::PropNameID::forAscii(rt, property),
                                                 1,  // key, value
                                                 [this](jsi::Runtime& runtime,
                                                        const jsi::Value& thisValue,
                                                        const jsi::Value* arguments,
                                                        size_t count) -> jsi::Value {
      
      if (arguments[0].isObject()) {
        facebook::jsi::Object jsiObject = arguments[0].getObject(runtime);
        
        std::shared_ptr<jsi::HostObject> hostObjectPtr = jsiObject.getHostObject(runtime);
        
        std::shared_ptr<DOMElementHostObject> domElementHostObject = std::static_pointer_cast<DOMElementHostObject>(hostObjectPtr);
        
        [element appendChildWithElement: domElementHostObject->element];
        
        return jsiObject;
      }

      return jsi::Value::undefined();
    });
  }
  
  if (property == "remove") {
    return jsi::Function::createFromHostFunction(rt,
                                                 jsi::PropNameID::forAscii(rt, property),
                                                 0,  // key, value
                                                 [this](jsi::Runtime& runtime,
                                                        const jsi::Value& thisValue,
                                                        const jsi::Value* arguments,
                                                        size_t count) -> jsi::Value {
      [element remove];
      
      return jsi::Value::undefined();
    });
  }

  return jsi::Value::undefined();
}

void DOMElementHostObject::set(jsi::Runtime& rt, const jsi::PropNameID &name, const jsi::Value &value) {
  std::string property = name.utf8(rt);

  if (property == "backgroundColor") {
    std::string color = value.asString(rt).utf8(rt);
    NSString *nsStr = [NSString stringWithUTF8String:color.c_str()];
    [element setBackgroundColorWithColor: nsStr];
  }
  
  if (property == "color") {
    std::string color = value.asString(rt).utf8(rt);
    NSString *nsStr = [NSString stringWithUTF8String:color.c_str()];
    [element setColorWithColor: nsStr];
  }
  
  if (property == "fontSize") {
    double fontSize = value.asNumber();
    [element setFontSizeWithFontSize: fontSize];
  }
  
  if (property == "height") {
    double height = value.asNumber();
    [element setHeightWithHeight: height];
  }
  
  if (property == "width") {
    double width = value.asNumber();
    [element setWidthWithWidth: width];
  }
  
  if (property == "top") {
    double top = value.asNumber();
    [element setTopWithTop: top];
  }
  
  if (property == "left") {
    double left = value.asNumber();
    [element setLeftWithLeft: left];
  }
  
  if (property == "textContent") {
    std::string textContent = value.asString(rt).utf8(rt);
    NSString *nsStr = [NSString stringWithUTF8String:textContent.c_str()];
    [element setTextContentWithTextContent: nsStr];
  }
  
  if (property == "onclick") {
    if (value.isObject() && value.asObject(rt).isFunction(rt)) {
    
      auto function = std::shared_ptr<jsi::Function>(new jsi::Function(value.asObject(rt).asFunction(rt)), [](jsi::Function* function) {
             delete function;
         });
      
      std::function<void()> stdFunction = [rt = std::shared_ptr<jsi::Runtime>(&rt, [](jsi::Runtime*) {}), function]() {
                function->call(*rt);
            };

      void (^block)() = ^{
           stdFunction();
       };
      
      [element onClickWithAction:block];
    }
  }

}
