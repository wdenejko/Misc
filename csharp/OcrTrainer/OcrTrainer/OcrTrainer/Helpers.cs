using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Windows.Media.Imaging;
using UPImage;

namespace OcrTrainer
{
    public class Helpers
    {
        public List<InputPattern> GetPatternsFromBitmap(InputPattern parentPattern, int hStep, int vStep, bool isTopStart, int minWidth, int minHeight)
        {
            List<InputPattern> patternlist = null;
            parentPattern.GetPatternBoundaries(hStep, vStep, isTopStart, minWidth, minHeight);
            if (parentPattern.PatternRects.Count > 0)
            {
                patternlist = new List<InputPattern>();
                foreach (var rect in parentPattern.PatternRects)
                {
                    var bmp = new Bitmap(rect.Width, rect.Height);
                    var graph = Graphics.FromImage(bmp);
                    graph.DrawImage(parentPattern.OriginalBmp, 0, 0, rect, GraphicsUnit.Pixel);
                    var x = parentPattern.OriginalRectangle.X + rect.X;
                    var y = parentPattern.OriginalRectangle.Y + rect.Y;
                    var newRect = new Rectangle(x, y, rect.Width, rect.Height);
                    var childPattern = new InputPattern(bmp, 255, newRect);
                    patternlist.Add(childPattern);
                    graph.Dispose();
                }
            }

            return patternlist;
        }

        public BitmapImage BitmapToImageSource(Bitmap bitmap)
        {
            using (var memory = new MemoryStream())
            {
                bitmap.Save(memory, System.Drawing.Imaging.ImageFormat.Bmp);
                memory.Position = 0;
                var bitmapimage = new BitmapImage();
                bitmapimage.BeginInit();
                bitmapimage.StreamSource = memory;
                bitmapimage.CacheOption = BitmapCacheOption.OnLoad;
                bitmapimage.EndInit();

                return bitmapimage;
            }
        }
    }
}
