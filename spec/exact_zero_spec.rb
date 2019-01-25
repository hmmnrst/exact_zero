require "bigdecimal"

i = Integer(0)
r = Rational(0)
f = Float(0)
b = BigDecimal(0)

RSpec.describe "Numeric#exact_zero?" do
	context "for Real zeroes" do
		it "returns true when Integer or Rational" do
			expect(i.exact_zero?).to be true
			expect(r.exact_zero?).to be true
		end

		it "returns false when floating-point numbers" do
			expect(f.exact_zero?).to be false
			expect(b.exact_zero?).to be false
		end
	end

	context "for Complex zeroes" do
		it "returns true when all of its components are Integer or Rational" do
			expect(Complex(i, i).exact_zero?).to be true
			expect(Complex(i, r).exact_zero?).to be true
			expect(Complex(r, i).exact_zero?).to be true
			expect(Complex(r, r).exact_zero?).to be true
		end

		it "returns false when any of its components are floating-point numbers" do
			expect(Complex(i, f).exact_zero?).to be false
			expect(Complex(i, b).exact_zero?).to be false
			expect(Complex(r, f).exact_zero?).to be false
			expect(Complex(r, b).exact_zero?).to be false
			expect(Complex(f, i).exact_zero?).to be false
			expect(Complex(f, r).exact_zero?).to be false
			expect(Complex(f, f).exact_zero?).to be false
			expect(Complex(f, b).exact_zero?).to be false
			expect(Complex(b, i).exact_zero?).to be false
			expect(Complex(b, r).exact_zero?).to be false
			expect(Complex(b, f).exact_zero?).to be false
			expect(Complex(b, b).exact_zero?).to be false
		end
	end

	context "for nonzeroes" do
		it "returns false" do
			expect(Integer("1").exact_zero?).to be false
			expect(Rational("2/3").exact_zero?).to be false
			expect(Complex("45-6/7i").exact_zero?).to be false
		end
	end
end
