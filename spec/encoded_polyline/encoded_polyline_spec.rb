require 'spec_helper'

describe EncodedPolyline, ".encode" do
  it "encodes a single point" do
    EncodedPolyline.encode(-179.9832104).should == "`~oia@"
  end

  it "encodes a very slightly negative point" do
    # Due to precision errors, verify that a negative value that rounds to 0 works.
    EncodedPolyline.encode(-3e-6).should == "?"
  end
end

describe EncodedPolyline, ".decode" do
  it "decodes a single point" do
    EncodedPolyline.decode('`~oia@').should be_close(-179.9832104, 0.0001)
  end
end

def should_be_similar_points(arr1, arr2)
  arr1.each_with_index do |(x,y),i|
    x.should be_close(arr2[i][0], 0.0001)
    y.should be_close(arr2[i][1], 0.0001)
  end
end

describe EncodedPolyline, ".decode_points" do
  let(:ring_points) { [[37.79297, -122.39676], [37.78987, -122.40075], [37.7894, -122.401], [37.78573, -122.40512], [37.78553, -122.40598], [37.78417, -122.40744], [37.78153, -122.41122], [37.77895, -122.41474], [37.77501, -122.41894], [37.77447, -122.41851], [37.77332, -122.41688], [37.77081, -122.41345], [37.77013, -122.40959], [37.77291, -122.40332], [37.77379, -122.40186], [37.77515, -122.40075], [37.77691, -122.39766], [37.77997, -122.39525], [37.78417, -122.39242], [37.78729, -122.38959], [37.78906, -122.38959], [37.79068, -122.39131], [37.79258, -122.39431], [37.79258, -122.39431], [37.79297, -122.39676], [37.78987, -122.40075], [37.7894, -122.401], [37.78573, -122.40512], [37.78553, -122.40598], [37.78417, -122.40744], [37.78153, -122.41122], [37.77895, -122.41474], [37.77501, -122.41894], [37.77447, -122.41851], [37.77332, -122.41688], [37.77081, -122.41345], [37.77013, -122.40959], [37.77291, -122.40332], [37.77379, -122.40186], [37.77515, -122.40075], [37.77691, -122.39766], [37.77997, -122.39525], [37.78417, -122.39242], [37.78729, -122.38959], [37.78906, -122.38959], [37.79068, -122.39131], [37.79258, -122.39431], [37.79258, -122.39431]] }

  let(:ring_text) { "amteFvr`jVjR|W|Ap@|UvXf@jDnGbHnOrVbO~TrWfYjBuAdFeItNmTfCcWkPef@oDcHoG}E_JiRcRaNgYuPoRuPaJ?cIvI{JvQ??mAhNjR|W|Ap@|UvXf@jDnGbHnOrVbO~TrWfYjBuAdFeItNmTfCcWkPef@oDcHoG}E_JiRcRaNgYuPoRuPaJ?cIvI{JvQ??" }

  it "encodes a pair of points" do
    EncodedPolyline.encode_points([[37.782,-122.406]]).should == "ohreFnlbjV"
  end

  it "should decode" do
    should_be_similar_points(EncodedPolyline.decode_points(ring_text), ring_points)
  end

  it "encodes points with little variation" do
    points = [[37.79297, -122.39676],[37.79297, -122.39676],[37.79297, -122.39676]]
    should_be_similar_points(EncodedPolyline.decode_points(EncodedPolyline.encode_points(points)), points)
  end

  it "truncates to 5 digits of accuracy" do
    points = [[37.79297111, -122.39676222],[37.79297333, -122.39676444],[37.79297555, -122.39676666]]
    points_2 = [[37.79297, -122.39676],[37.79297, -122.39676],[37.79297, -122.39676]]
    should_be_similar_points(EncodedPolyline.decode_points(EncodedPolyline.encode_points(points)), points_2)
  end

end
