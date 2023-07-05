#import "InitialiseJSRuntime.h"
#import <jsi/jsi.h>
#include <hermes/hermes.h>


using namespace facebook;


@implementation InitialiseJSRuntime

- (void)initialiseJSRuntime {
  auto hermesRuntime = facebook::hermes::makeHermesRuntime();
  auto INJECTED_SCRIPT = "let a = 1+2;";
  hermesRuntime->evaluateJavaScript(std::make_unique<facebook::jsi::StringBuffer>(INJECTED_SCRIPT), "");
}

@end
