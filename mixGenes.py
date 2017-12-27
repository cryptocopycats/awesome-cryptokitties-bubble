##################################
# CryptoKitties GeneScience algorithm by Alex Hegyi, Dec 23
#   see https://medium.com/@alexhegyi/cryptokitties-genescience-1f5b41963b0d
#
# > My winter holiday thus far has consisted of staring at disassembled bytecode 
# > until I had everything figured out:
#
# Source:
#  https://github.com/heglex/gene-science/blob/master/Cryptokitties%20mixGenes%20test.ipynb
#

# These examples are from Tx 0xa7b0ac87684771f6d6204a09b5a0bf0b97f6adf61b78138e8fd264828e36b956

# matron.genes
arg1 = 0x000063169218f348dc640d171b000208934b5a90189038cb3084624a50f7316c

# sire.genes
arg2 = 0x00005a13429085339c6521ef0300011c82438c628cc431a63298e3721f772d29

# matron.cooldownEndBlock - 1
arg3 = 0x000000000000000000000000000000000000000000000000000000000047ff27

# BLOCKHASH of block number equal to arg3
blockhash = 0xf9dd4486d68b13839d2f7b345f5223f17abae39a951f2cea5b0ca0dd6dc8db83


# load arguments into bytes arrays in big-Endian order

args1 = []
for cnt in range(32):
    args1.append(arg1//((1<<8)**cnt)&0xff)
args1.reverse()
args1 = bytes(args1)

args2 = []
for cnt in range(32):
    args2.append(arg2//((1<<8)**cnt)&0xff)
args2.reverse()
args2 = bytes(args2)


args3 = []
for cnt in range(32):
    args3.append(arg3//((1<<8)**cnt)&0xff)
args3.reverse()
args3 = bytes(args3)

blockhashes = []
for cnt in range(32):
    blockhashes.append(blockhash//((1<<8)**cnt)&0xff)
blockhashes.reverse()
blockhashes = bytes(blockhashes)

# concatenate bytes arrays

alls =  blockhashes + args1 + args2 + args3


# get hash of bytes arrays. This is your source of "randomness"

hash = sha3.keccak_256(alls)
hash = int.from_bytes(hash.digest(), byteorder = 'big')

print(hex(hash))

# => 0xe30dd999bfba6dd6cd4540fb58c5a1c117e6938c0931459b1c9f6e01d865c19e


# get 5-bit chunks of matron and sire

def masker(arg, start, numbytes):
    mask = 2**numbytes - 1
    mask = mask << start
    out = arg & mask
    out = out >> start
    
    return out

arg1masks = []
for cnt in range(0x30):
    arg1masks.append(masker(arg1, 5*cnt, 5))
    
arg2masks = []
for cnt in range(0x30):
    arg2masks.append(masker(arg2, 5*cnt, 5))
    
arg1maskscopy = arg1masks.copy()
arg2maskscopy = arg2masks.copy()

# note in worst case hashindex wont reach 256 so no need for modulo
hashindex = 0

# swap dominant/recessive genes according to masked_hash
for bigcounter in range(0x0c):
    for smallcounter in range(3, 0, -1):
        count = 4*bigcounter + smallcounter
        
        masked_hash = masker(hash, hashindex, 2)
        hashindex += 2
        if masked_hash == 0:
            tmp = arg1maskscopy[count - 1]
            arg1maskscopy[count - 1] = arg1maskscopy[count]
            arg1maskscopy[count] = tmp
            
        masked_hash = masker(hash, hashindex, 2)
        hashindex += 2
        if masked_hash == 0:
            tmp = arg2maskscopy[count - 1]
            arg2maskscopy[count - 1] = arg2maskscopy[count]
            arg2maskscopy[count] = tmp

# combine genes from swapped parent genes, introducing mutations

outmasks = []
for cnt in range(0x30):
    rando_byte = 0
    
    # mutate only on dominant genes
    if cnt%4 == 0:
        tmp1 = arg1maskscopy[cnt]&1
        tmp2 = arg2maskscopy[cnt]&1

        if tmp1 != tmp2:
            masked_hash = masker(hash, hashindex, 3)
            hashindex += 3
            
            mask1 = arg1maskscopy[cnt]
            mask2 = arg2maskscopy[cnt]
            
            # mutate only if the two parent dominant genes differ by 1...
            if abs(mask2 - mask1) == 1:
                min_mask = min(mask1, mask2)
                # and the smaller of the two is even...
                if min_mask % 2 == 0:
                    if min_mask < 0x17:
                        trial = masked_hash > 1
                    else:
                        trial = masked_hash > 0
                    if not trial:
                        # mutation is the smaller of the two parent dominant genes,
                        # divided by two, plus 16
                        rando_byte = (min_mask >> 1) + 0x10
        
        if rando_byte > 0:
            print(cnt)
            outmasks.append(rando_byte)
            continue
                                
    masked_hash = masker(hash, hashindex, 1)
    hashindex += 1
    
    if masked_hash == 0:
        outmasks.append(arg1maskscopy[cnt])
    else:
        outmasks.append(arg2maskscopy[cnt])


# this is where we will accumulate the calculated child genes
outs = 0

# this is where you can put the known child genes, for testing
outs2 = 0x5b174298a44b9c6521176000021c53734c9018c431a73298674a5177316c

for cnt in range(0x30):
    outs |= outmasks[cnt] << 5*cnt

# print both for comparison
print(hex(outs))
print(hex(outs2))

# => 0x5b174298a44b9c6521176000021c53734c9018c431a73298674a5177316c
# => 0x5b174298a44b9c6521176000021c53734c9018c431a73298674a5177316c




