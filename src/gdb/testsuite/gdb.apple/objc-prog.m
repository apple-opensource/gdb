#import <Foundation/Foundation.h>

/* The following stolen from gdb.obj/myclass.m, written by Adam Fedor */

@interface MyClass: NSObject
{
  id object;
  id _object2;
}
+ newWithArg: arg;
- takeArg: arg;
- randomFunc;
@end

@implementation MyClass
+ newWithArg: arg
{
  id obj = [self new];
  [obj takeArg: arg];
  return obj;
}

- takeArg: arg
{
  object = arg;
  [object retain];
  _object2 = arg;
  [_object2 retain];
  return self;
}

- randomFunc
{
  puts ("hi");  /* Whatever, just a place to break and examine SELF in gdb */
}

@end

/* End of stolen code from gdb.obj/myclass.m, written by Adam Fedor */


void stringmaker (void);
int blocky (void);
int return_5 (void);
NSNumber *return_nsnumber_5 (void);
NSNumber *return_nsnumber_from_int (int);
NSNumber *return_nsnumber_from_char (char);

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    id object = [MyClass newWithArg:@"hi there"];
    [object randomFunc];
    
    stringmaker ();

    blocky ();

    [pool release];
    return 0;
}

void stringmaker (void) {
    NSString *mystr = @"Hello, World!"; /* this should be the first line in stringmaker */

    NSLog (mystr);
}

int return_5 (void ) { return 5; }

NSNumber *return_nsnumber_5 (void ) { return [NSNumber numberWithInt:5]; }

NSNumber *return_nsnumber_from_int (int num) 
     { return [NSNumber numberWithInt:num]; }

NSNumber *return_nsnumber_from_char (char num) 
     { return [NSNumber numberWithChar:num]; }

int blocky (void) {
  int outer;
  outer = 5;
  { 
    char inner1;
    inner1 = 'a';
    inner1 = 'b';
    inner1 = 'c';
    int inner2;
    inner2 = 99;

    {
      int outer;  /* psych! */
      outer = 10;
    }

    {
      float flooooo = 10.3;
      char chhhhh = 'Z';
    }
  }
  return 0;
}
