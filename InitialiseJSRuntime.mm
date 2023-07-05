#import "InitialiseJSRuntime.h"
#import <jsi/jsi.h>
#include <hermes/hermes.h>


using namespace facebook;


@implementation InitialiseJSRuntime

- (void)initialiseJSRuntime {
  auto hermesRuntime = facebook::hermes::makeHermesRuntime();
  
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


  auto INJECTED_SCRIPT = "let a = 1+2; console.log('hello react nexus '+a)";
  
  hermesRuntime->evaluateJavaScript(std::make_unique<facebook::jsi::StringBuffer>(INJECTED_SCRIPT), "");



}

@end
