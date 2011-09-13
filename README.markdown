# EncodedPolyline

EncodedPolyline implements [Google's algorithm](http://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html) for compressing arrays of geographic points. The compressed string can then be passed to the Google Maps API.
The Maps API limits URL requests to 2048 characters. This library does not enforce this limit on the encoding length.

## Installation

    gem install encoded_polyline

## Examples

Using the library:

    EncodedPolyline.encode(-179.9832104)               # "`~oia@"
    EncodedPolyline.decode("`~oia@")                   # -179.98321
    EncodedPolyline.encode_points([[37.782,-122.406]]) # "ohreFnlbjV"
    EncodedPolyline.decode_points("ohreFnlbjV")        # [[37.782,-122.406]]

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

