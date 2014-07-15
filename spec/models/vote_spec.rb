describe Vote do
  describe "validations" do
    before do
      @vote = Vote.new
    end

    describe "value validation" do
      it "allows -1 as a value" do
        @vote.value= 1
        expect(@vote.valid?).to eq(true)
      end
      it "allows 1 as a value" do
        @vote.value= -1
        expect(@vote.valid?).to eq(true)
      end
      it "does not allow a value other than -1 or 1)" do
        @vote.value= 5
        expect(@vote.valid?).to eq(false)
      end
    end
  end
end
