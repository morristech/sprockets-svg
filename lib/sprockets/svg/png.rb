require 'rmagick'

module Sprockets
  module Svg
    module Png
      def self.included(base)
        base.send(:alias_method, :write_to_without_png_convertion, :write_to)
        base.send(:alias_method, :write_to, :write_to_with_png_convertion)
      end

      def write_to_with_png_convertion(path, options={})
        write_to_without_png_convertion(path, options)
        if path.ends_with?('.svg')
          Png.convert(path, path + '.png')
        end
        nil
      end

      # TODO: integrate svgo instead: https://github.com/svg/svgo
      # See https://github.com/lautis/uglifier on how to integrate a npm package as a gem.
      def self.convert(svg_path, png_path)
        image = Magick::ImageList.new(svg_path)
        image.write(png_path)
      end
    end
  end
end