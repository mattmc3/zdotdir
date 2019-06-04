# java -------------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  # run this: /usr/libexec/java_home -v 10
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home"

  # alias j12="export JAVA_HOME=\`/usr/libexec/java_home -v 12\`; java -version"
  # alias j11="export JAVA_HOME=\`/usr/libexec/java_home -v 11\`; java -version"
  # alias j10="export JAVA_HOME=\`/usr/libexec/java_home -v 10\`; java -version"
fi
