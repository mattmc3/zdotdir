### java ------------------------------------------------------------------- {{{
if [[ "$OSTYPE" == darwin* ]]; then
  # get path to Java 10: /usr/libexec/java_home -v 10
  # export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home"

  export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home
  export PENTAHO_JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

  alias j8="export JAVA_HOME=\`/usr/libexec/java_home -v 8\`; java -version"
  alias j14="export JAVA_HOME=\`/usr/libexec/java_home -v 14\`; java -version"
fi
