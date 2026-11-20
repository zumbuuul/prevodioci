java -cp lib/JFlex.jar JFlex.Main -d src src/spec2.flex
mkdir -p out
javac -encoding UTF-8 -d out src/*.java
java -cp out MPLexer2 src/testinput.txt