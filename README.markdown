# EncodedPolyline

EncodedPolyline implements [Google's algorithm](http://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html) for compressing arrays of geographic points. The compressed string can then be passed to the Google Maps API.
The Maps API limits URL requests to 2048 characters. This library does not enforce this limit on the encoding length.
This coordinate encoding scheme is also compatible with [MapQuest Platform Services](http://open.mapquestapi.com/common/encodedecode.html), which supports variable decimal precision. The default precision of 5 is appropriate for compatibility with the Google Maps API.

## Installation

    gem install encoded_polyline

## Examples

Using the library with default decimal precision of 5:

    EncodedPolyline.encode(-179.9832104)                  # "`~oia@"
    EncodedPolyline.decode("`~oia@")                      # -179.98321
    EncodedPolyline.encode_points([[37.782,-122.406]])    # "ohreFnlbjV"
    EncodedPolyline.decode_points("ohreFnlbjV")           # [[37.782,-122.406]]

Using the library with explicit decimal precisions:

    EncodedPolyline.encode(-179.9832104, 7)               # "na`|gjB"
    EncodedPolyline.decode("na`|gjB", 7)                  # -179.9832104
    EncodedPolyline.encode_points([[37.782,-122.406]], 2) # "ckF`|V"
    EncodedPolyline.decode_points("ckF`|V", 2)            # [[37.78, -122.41]]

It is important to specify the same precision when encoding and decoding. Otherwise, decoded coordinates may be wrong by orders of magnitude.

## Performance

Included is a benchmark that creates a 100-point random walk, gives you a URL, and encodes/decodes it 10,000 times (1 million points total).

    Raw length(JSON):     3682 characters
    Encoded length:       495 characters
    Compression ratio:    0.134437805540467

                              user     system      total        real
    encoding              9.090000   0.000000   9.090000 (  9.092519)
    decoding             16.470000   0.010000  16.480000 ( 16.473547)

## Known Issues

Haven't tested with Ruby 1.9; probably doesn't work.

