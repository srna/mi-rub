'''
Created on Nov 21, 2011

@author: vikturek

Edited Nov 30, 2012

@author: strny
'''

import sys
import os
import random

def generateTest2(testInput):
    if os.path.exists(testInput):
        os.remove(testInput)
    rand = random
    testFile = file(testInput, "w")
    testFile.write("INT\n")
    for i in range(0, 10000):
        testFile.write("ADD ")
        testFile.write(str(rand.randint(0, 1000)) + "\n")
    testFile.close()

if __name__ == '__main__':
    
    score = 0.0
    valgrind = False
    
    print "\nTester pro domaci ukol 3 predmetu MI-RUB v zimnim semestru 2012\n"
    if len(sys.argv) == 3:
        if os.path.exists(sys.argv[1]):
            open(sys.argv[1])
        else:
            print "Chyba: Nemohu najit zadane referencni reseni!"
            sys.exit(1)
        if os.path.exists(sys.argv[2]):
            open(sys.argv[2])
        else:
            print "Chyba: Nemohu najit zadany zdrojovy soubor!"
            sys.exit(1)
    else:
        print "Tester vyzaduje jako prvni argument referencni reseni a jako druhy nazev zdrojoveho kodu k testovani."
        sys.exit(0)
    
    
    sys.stdout.write("\n\tTest 1 - vstup podle ukazky ... ")
    testInput = "inputs/test1"
    refOutput = "outputs/output1ref"
    testOutput = "outputs/output1test"  
    testedSource = "ruby hw3.rb "
    os.system("./" + sys.argv[1] + " " + testInput + " > " + refOutput)
    os.system(testedSource + " < " + testInput + " > " + testOutput)
    if os.system("diff " + refOutput + " " + testOutput + " > /dev/null") == 0:
        sys.stdout.write("OK\n")
        score += 1
    else:
        sys.stdout.write("Chyba!\n")
        print "\n\tVystupy " + refOutput + " a " + testOutput + " nejsou stejne!"
    
    sys.stdout.write("\n\tTest 2 - test nahodnymi hodnotami ... ")
    testInput = "inputs/test2"
    generateTest2(testInput)
    refOutput = "outputs/output2ref"
    testOutput = "outputs/output2test"
    os.system("./" + sys.argv[1] + " " + testInput + " > " + refOutput)
    os.system(testedSource + " < " + testInput + " > " + testOutput)
    if os.system("diff " + refOutput + " " + testOutput + " > /dev/null") == 0:
        sys.stdout.write("OK\n")
        score += 1
    else:
        sys.stdout.write("Chyba!\n")
        print "\n\tVystupy " + refOutput + " a " + testOutput + " nejsou stejne!"
    
    sys.stdout.write("\nDosazeno " + str(score/2*100) + "%.\n\n")
