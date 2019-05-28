var mystring1: string = "hello";
var blen1 = mystring1.length;

on Locales[numLocales-1] {
  writeln("Byte length = ", mystring1.length);
  writeln("Byte length = ", blen1);

  for i in 1..blen1 {
    writeln("Byte index ", i, " = '", mystring1[i: byteIndex], "'");
  }
}

var mystring2: string = "événement";
var cplen2 = mystring2.numCodepoints;

on Locales[numLocales-1] {
  writeln("Byte length = ", mystring2.length);
  writeln("Codepoint length = ", cplen2);

  for i in 1..cplen2 {
    writeln("Codepoint index ", i, " = '", mystring2[i: codepointIndex], "'");
  }
}
