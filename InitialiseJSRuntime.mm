#import "InitialiseJSRuntime.h"
#import <jsi/jsi.h>
#include <hermes/hermes.h>
#include "DOMDocumentHostObject.h"

using namespace facebook;


@implementation InitialiseJSRuntime

- (void)initialiseJSRuntime:(UIViewController*) rootController {
  auto hermesRuntime = facebook::hermes::makeHermesRuntime();
  jsi::Object document = jsi::Object::createFromHostObject(*hermesRuntime, std::make_shared<DOMDocumentHostObject>(rootController));

  hermesRuntime->global().setProperty(*hermesRuntime, "document",  document);

  auto console = jsi::Object(*hermesRuntime);
  console.setProperty(*hermesRuntime, "log",
                      jsi::Function::createFromHostFunction(*hermesRuntime, jsi::PropNameID::forAscii(*hermesRuntime, "log"),
                                                            1, [](jsi::Runtime& rt,
                                                                   const jsi::Value& thisValue,
                                                                   const jsi::Value* arguments,
                                                                   size_t count) -> jsi::Value {
    std::string elementType = arguments[0].asString(rt).utf8(rt);
    NSString *nsStr = [NSString stringWithUTF8String:elementType.c_str()];
    NSLog(@"%@", nsStr);

    return jsi::Value::undefined();
}));

  hermesRuntime->global().setProperty(*hermesRuntime, "console", console);


  auto INJECTED_SCRIPT = "let view = document.createElement('div'); document.appendChild(view); view.backgroundColor='rgba(0, 0, 0, 1.0)'; view.height=300; view.width=400; view.top = 150; view.textContent = 'Hello, React Nexus! ⚛'; view.color = 'rgba(55, 191, 201, 1.0)'; view.fontSize=16";
  
  hermesRuntime->evaluateJavaScript(std::make_unique<facebook::jsi::StringBuffer>(INJECTED_SCRIPT), "");



}

@end
