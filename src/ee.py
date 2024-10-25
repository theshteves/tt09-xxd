ee = ['e'*n for n in range(256)]
localparams = [f'localparam {e:256} = 8\'b{bin(i)[2:]:0>8};' for i, e in enumerate(ee)]
print('\n'.join(localparams))
