
myArray = [
            -35,-63,-65,32,86,66,126,-39,116,36,-12,91,49,-55,-79,98,
            49,123,24,3,123,24,-125,-61,36,-76,-73,-126,-52,-70,56,123,
            12,-37,-79,-98,61,-37,-90,-21,109,-21,-83,-66,-127,-128,-32,42,
            18,-28,44,92,-109,67,11,83,36,-1,111,-14,-90,2,-68,-44,
            -105,-52,-79,21,-48,49,59,71,-119,62,-18,120,-66,11,51,-14,
            -116,-102,51,-25,68,-100,18,-74,-33,-57,-76,56,12,124,-3,34,
            81,-71,-73,-39,-95,53,70,8,-8,-74,-27,117,53,69,-9,-78,
            -15,-74,-126,-54,2,74,-107,8,121,-112,16,-117,-39,83,-126,119,
            -40,-80,85,-13,-42,125,17,91,-6,-128,-10,-41,6,8,-7,55,
            -113,74,-34,-109,-44,9,127,-123,-80,-4,-128,-43,27,-96,36,-99,
            -79,-75,84,-4,-35,122,85,-1,29,21,-18,-116,47,-70,68,27,
            3,51,67,-36,100,110,51,114,-101,-111,68,90,95,-59,20,-12,
            118,102,-1,4,119,-77,80,85,-41,108,17,5,-105,-36,-7,79,
            24,2,25,112,-13,43,50,-88,-5,83,-61,-46,-115,58,-81,49,
            21,-46,66,43,-68,66,-77,-59,81,-76,-125,77,-17,-79,116,94,
            -80,2,72,-22,17,-7,-58,33,-14,113,127,119,127,26,76,37,
            2,-38,-38,96,-44,-18,-102,-116,-15,-124,-37,110,-109,-112,-117,-26,
            97,-91,42,76,-20,67,70,-94,-72,-36,-1,91,-31,-105,-98,-92,
            60,-46,-95,47,-76,34,111,-40,-67,48,-104,-65,61,-55,89,42,
            61,-93,93,-4,106,91,92,-39,92,-60,-97,12,-33,3,95,-47,
            -23,120,86,71,85,23,-105,-121,85,-25,-63,-51,85,-113,-75,-75,
            6,-86,-71,99,59,103,44,-116,109,-37,-25,-28,-109,2,-49,-86,
            108,97,83,-84,-110,-9,124,21,-6,7,61,-91,-6,109,-67,-11,
            -110,122,-110,-6,82,-126,57,83,-6,9,-84,17,-101,14,-27,-12,
            5,14,10,45,-74,117,95,-46,55,-118,-119,-73,56,-118,-75,-55,
            5,92,-116,-65,72,92,-85,-80,-1,-63,-102,90,-1,86,-36,78
        ]

print(''.join(chr(byte & 0xFF) for byte in myArray)) # machine code
