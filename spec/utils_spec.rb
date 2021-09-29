$: << 'lib'
require 'utils'

describe Utils do
  describe 'self.uniquely_join_hashes_of_arrays' do
    context 'when proper hashes with arrays are given' do
      let(:hash1) {
        {a: [1, 2, 3], b: [2, 3, 4]}
      }
      let(:hash2) {
        {a: [1, 2, 3, 4], b: [2, 5], c: [3, 4]}
      }
      let(:hash3) {
        {a: [5, 1], d: [1, 3, 4]}
      }
      it 'returns proper hash with arrays joined uniquely' do
        result = Utils.uniquely_join_hashes_of_arrays(hash1, hash2, hash3)
        expect(result).to eql({
          a: [1, 2, 3, 4, 5],
          b: [2, 3, 4, 5],
          c: [3, 4],
          d: [1, 3, 4]
        })
      end
    end
  end
end