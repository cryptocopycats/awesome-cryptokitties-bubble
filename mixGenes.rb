#################
#  CryptoKitties geneScience.mixGenes - "magic" sooper-sekret gene mixing operation forumula (ruby edition)
#    to run use:
#      $ ruby ./mixGenes.rb
#
#
#  based on the pseudo-code published by Sean Soria
#    in "CryptoKitties mixGenes Function"
#    see https://medium.com/@sean.soria/cryptokitties-mixgenes-function-69207883fc80
#
#  original call in kitty script:
#   uint256 childGenes = geneScience.mixGenes(matron.genes, sire.genes, matron.cooldownEndBlock - 1);
#
#   see https://etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code
#   opscode:
#
#  PUSH1 0x60
#  PUSH1 0x40
#  MSTORE
#  PUSH1 0x04
#  CALLDATASIZE
#  LT
#  PUSH2 0x006c
#  JUMPI
#  PUSH4 0xffffffff
#  PUSH29 0x0100000000000000000000000000000000000000000000000000000000
#  PUSH1 0x00
#  CALLDATALOAD
#  DIV
#  AND
#  PUSH4 0x0d9f5aed
#  ...
#
#  pseudo code:
#
# def mixGenes(mGenes[48], sGenes[48], babyGenes[48]):
#    # PARENT GENE SWAPPING
#  for (i = 0; i < 12; i++):
#    index = 4 * i
#    for (j = 3; j > 0; j--):
#      if random() < 0.25:
#        swap(mGenes, index+j, index+j-1)
#      if random() < 0.25:
#        swap(sGenes, index+j, index+j-1)
#  # BABY GENES
#  for (i = 0; i < 48; i++):
#    mutation = 0
#    # CHECK MUTATION
#    if i % 4 == 0:
#      gene1 = mGene[i]
#      gene2 = sGene[i]
#      if gene1 > gene2:
#        gene1, gene2 = gene2, gene1
#      if (gene2 - gene1) == 1 and iseven(gene1):
#        probability = 0.25
#        if gene1 > 23:
#          probability /= 2
#        if random() < probability:
#          mutation = (gene1 / 2) + 16
#    # GIVE BABY GENES
#    if mutation:
#      baby[i] = mutation
#    else:
#      if random() < 0.5:
#        babyGenes[i] = mGene[i]
#      else:
#        babyGenes[i] = sGene[i]



def mixgenes( mgenes, sgenes )  ## returns babygenes
  ## note: reverse genes strings (in kai) so index 0 is the first number
  ##                                         index 1 is the second number etc.
  mgenes = mgenes.reverse
  sgenes = sgenes.reverse

  babygenes = "?"*48      ## string with 48 question marks (?)

  # PARENT GENE SWAPPING
  12.times do |i| # loop from 0 to 11        # for(i = 0; i < 12; i++)
    puts "parent gene swapping i: #{i}"
    index = 4*i                              #   index = 4 * i
    3.downto(1) do |j| ## loop from 3 to 1   #   for (j = 3; j > 0; j--)
      puts "   j: #{j}"
      if rand(100) < 25                      #     if random() < 0.25:
        mgenes[index+j-1], mgenes[index+j] = #       swap(mGenes, index+j, index+j-1)
        mgenes[index+j],   mgenes[index+j-1]
      end
      if rand(100) < 25                      #     if random() < 0.25:
        sgenes[index+j-1], sgenes[index+j] = #        swap(sGenes, index+j, index+j-1)
        sgenes[index+j],   sgenes[index+j-1]
      end
    end
  end

  # BABY GENES
  48.times do |i| # loop from 0 to 47        #  for (i = 0; i < 48; i++):
    puts "baby genes i: #{i}"
    mutation = nil                           #    mutation = 0
                                             #    # CHECK MUTATION
    if i % 4 == 0                            #    if i % 4 == 0:
      gene1 = Kai::NUMBER[ mgenes[i] ]       #      gene1 = mGene[i]
      gene2 = Kai::NUMBER[ sgenes[i] ]       #      gene2 = sGene[i]
      if gene1 > gene2                       #      if gene1 > gene2:
         gene1, gene2 = gene2, gene1        #        gene1, gene2 = gene2, gene1
      end
      if (gene2 - gene1) == 1 && gene1.even? #     if (gene2 - gene1) == 1 and iseven(gene1):
        probability = 25                     #        probability = 0.25
        if gene1 > 23                        #        if gene1 > 23:
          probability /= 2                   #          probability /= 2
        end
        if rand(100) < probability                   #        if random() < probability:
          mutation = Kai::ALPHABET[ (gene1/2)+16 ]   #          mutation = (gene1 / 2) + 16
        end
      end
    end
    # GIVE BABY GENES
    if mutation                              #    if mutation:
      babygenes[i]=mutation                   #      baby[i] = mutation
    else                                     #    else:
      if rand(100) < 50                      #      if random() < 0.5:
        babygenes[i] = mgenes[i]             #        babyGenes[i] = mGene[i]
      else                                   #      else:
        babygenes[i] = sgenes[i]             #        babyGenes[i] = sGene[i]
      end
    end
  end

  babygenes.reverse   # return bagygenes (reversed back)
end # mixgenes


### let's add base32 / kai helper class

class Base32   ## Base32  (2^5 - 5bits)

  # See https://en.wikipedia.org/wiki/Base58
  ALPHABET = "123456789abcdefghijkmnopqrstuvwx"
  BASE     = ALPHABET.length   ## 32 chars/letters/digits

  # Converts a base10 integer to a base32 string.
  def self.encode( num )
    buf = String.new
    while num >= BASE
      mod = num % BASE
      buf = ALPHABET[mod] + buf
      num = (num - mod)/BASE
    end
    ALPHABET[num] + buf
  end

  NUMBER = {
   '1' => 0,  '2' => 1,  '3' => 2,  '4' => 3,  '5' => 4,  '6' => 5,  '7' => 6,  '8' => 7,
   '9' => 8,  'a' => 9,  'b' => 10, 'c' => 11, 'd' => 12, 'e' => 13, 'f' => 14, 'g' => 15,
   'h' => 16, 'i' => 17, 'j' => 18, 'k' => 19, 'm' => 20, 'n' => 21, 'o' => 22, 'p' => 23,
   'q' => 24, 'r' => 25, 's' => 26, 't' => 27, 'u' => 28, 'v' => 29, 'w' => 30, 'x' => 31
  }

  def self.fmt( kai )
    ## format in groups of four (4) separated by space
    ##  e.g.  ccac7787fa7fafaa16467755f9ee444467667366cccceede
    ##     :  ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede
    kai.reverse.gsub( /(.{4})/, '\1 ').reverse.strip
  end
end  # class Base32


## add a shortcut (convenience) alias
Kai = Base32
# why kai?
#  in honor of Kai Turner who deciphered the genes - thanks!
#    see https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4



#####################
# let's go

mgenes_hex = 0x000063169218f348dc640d171b000208934b5a90189038cb3084624a50f7316c
sgenes_hex = 0x00005a13429085339c6521ef0300011c82438c628cc431a63298e3721f772d29


mgenes = Kai.encode( mgenes_hex )   # convert to 5-bit (base32/kai) notation
p mgenes
# => "ddca578ka4f7949p4d11535kaeea175h846k2243aa9gfdcd"
p Kai.fmt( mgenes )
# => "ddca 578k a4f7 949p 4d11 535k aeea 175h 846k 2243 aa9g fdcd"
p mgenes.size
# => 48

sgenes = Kai.encode( sgenes_hex )
p sgenes
# => "c9am65567ff7b9gg1d1138539f77647577k46784f9gpfcaa"
p Kai.fmt( sgenes )
# => "c9am 6556 7ff7 b9gg 1d11 3853 9f77 6475 77k4 6784 f9gp fcaa"
p sgenes.size
# => 48

babygenes = mixgenes( mgenes, sgenes )
p babygenes
# => "9dca5586aff7b99p1d1133k5aea767h574kk6744aafgffaa"
p Kai.fmt( babygenes )
# => "9dca 5586 aff7 b99p 1d11 33k5 aea7 67h5 74kk 6744 aafg ffaa"
