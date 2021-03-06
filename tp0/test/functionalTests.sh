#!/usr/bin/env bash


FAILED_TESTS_COUNT=0

#1. Generamos una imagen de 1 punto de lado, centrada en el orı́gen del plano complejo

OUTPUT="$(../build/tp0 -c 0.01+0i -r 1x1 -o -)"
TEST1_OUTPUT=$'P2\n1 1\n255\n19'

if [ "$OUTPUT" == "$TEST1_OUTPUT" ]
then
    echo "Test 1 OK"
else
    FAILED_TESTS_COUNT=$[$FAILED_TESTS_COUNT+1]
    echo "Test 1 FAIL: Expected '$OUTPUT' to be equal to '$TEST1_OUTPUT'"
fi

#2. Repetimos el experimento, pero nos centramos ahora en un punto que seguro no pertenece al conjunto

OUTPUT="$(../build/tp0 -c 10+0i -r 1x1 -o -)"
TEST2_OUTPUT=$'P2\n1 1\n255\n0'

if [ "$OUTPUT" == "$TEST2_OUTPUT" ]
then
    echo "Test 2 OK"
else
    FAILED_TESTS_COUNT=$[$FAILED_TESTS_COUNT+1]
    echo "Test 2 FAIL: Expected '$OUTPUT' to be equal to '$TEST2_OUTPUT'"
fi

#3. Imagen imposible
OUTPUT="$(../build/tp0 -c 0+0i -r 0x1 -o - 2>&1)"
TEST3_OUTPUT=$'Usage:\n tp0 -r: resolution nxm being n width and m height. They both have to be integers higher than 0.\n tp0 -c: specifies the center of the image in a binomial form. Example: a+bi\n tp0 -C: specifies the parameter c in a binomial form like the center.\n tp0 -w: specifies the width of the rectangle that contains the region we are about to draw.\n tp0 -H: specifies the height of the rectangle that contains the region we are about to draw.\n tp0 -o: you can specifie the output pgm file as an argument, or put - to get the result as a standard output.\n tp0 -r 1280x728 -c 1.0015-1.254i -C -1.125-0.21650635094611i -w 4.5 -H 3.3 -0 dos.pgm: as an example combining every parameter.'

if [ "$OUTPUT" == "$TEST3_OUTPUT" ]
then
    echo "Test 3 OK"
else
    FAILED_TESTS_COUNT=$[$FAILED_TESTS_COUNT+1]
    echo "Test 3 FAIL: Expected '$OUTPUT' to be equal to '$TEST3_OUTPUT'"

fi


#4. Archivo de salida imposible
OUTPUT="$(../build/tp0 -o /tmp 2>&1)"
TEST4_OUTPUT=$'fatal: cannot open output file.'

if [ "$OUTPUT" == "$TEST4_OUTPUT" ]
then
    echo "Test 4 OK"
else
    FAILED_TESTS_COUNT=$[$FAILED_TESTS_COUNT+1]
    echo "Test 4 FAIL: Expected '$OUTPUT' to be equal to '$TEST4_OUTPUT'"
fi

#5. Coordenadas complejas imposibles
OUTPUT="$(../build/tp0 -c 1+3 -o - 2>&1)"
TEST5_OUTPUT=$'fatal: invalid center specification.'

if [ "$OUTPUT" == "$TEST5_OUTPUT" ]
then
    echo "Test 5 OK"
else
    FAILED_TESTS_COUNT=$[$FAILED_TESTS_COUNT+1]
    echo "Test 5 FAIL: Expected '$OUTPUT' to be equal to '$TEST5_OUTPUT'"
fi

#6. Argumentos de lı́nea de comando vacı́os.
OUTPUT="$(../build/tp0 -c "" -o - 2>&1)"
TEST6_OUTPUT=$'fatal: invalid center specification.'

if [ "$OUTPUT" == "$TEST6_OUTPUT" ]
then
    echo "Test 6 OK"
else
    FAILED_TESTS_COUNT=$[$FAILED_TESTS_COUNT+1]
    echo "Test 6 FAIL: Expected '$OUTPUT' to be equal to '$TEST6_OUTPUT'"
fi


#Summary
if [ "$FAILED_TESTS_COUNT" == 0 ]
then
 echo "All tests passed!."
else
echo "$FAILED_TESTS_COUNT test failed."
fi

