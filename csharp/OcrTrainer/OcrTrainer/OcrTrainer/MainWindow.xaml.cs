using System;
using System.Drawing;
using System.Windows;
using System.Windows.Forms;
using Emgu.CV;
using Emgu.CV.Structure;
using UPImage;

namespace OcrTrainer
{
    public partial class MainWindow
    {
        private Bitmap _drawBitmap;
        private Bitmap _bitmap;
        private Bitmap _graySourceBitmap;
        public Helpers Helpers { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private void SetImageButton_Click(object sender, RoutedEventArgs e)
        {
            var openfile = new OpenFileDialog();
            this.Helpers = new Helpers();
            openfile.ShowDialog();
            if (!openfile.CheckFileExists) return;
            var originalImage = new Image<Bgr, byte>(openfile.FileName);
            //         var originalResized = originalImage.Resize(1024, 768, Inter.Linear);
            SourceImage.Source = this.Helpers.BitmapToImageSource(originalImage.Bitmap);
            var originalGrayImage = new Image<Gray, byte>(openfile.FileName);
            //           var greyResized = originalGrayImage.Resize(1024, 768, Inter.Linear);
            GrayScaleImage.Source = this.Helpers.BitmapToImageSource(originalGrayImage.Bitmap);
            _graySourceBitmap = originalGrayImage.Bitmap;
        }

        private void CharacterRecognizeButton_Click(object sender, EventArgs e)
        {
            if (_bitmap != null && this.Helpers != null)
            {
                _bitmap.Dispose();
                _bitmap = null;
            }
            _bitmap = new Bitmap(_graySourceBitmap.Width, _graySourceBitmap.Height);
            _drawBitmap = (Bitmap)_graySourceBitmap.Clone();
            if (_bitmap == null || this.Helpers == null) return;
            var parentPt = new InputPattern(_graySourceBitmap, 255, new Rectangle(0, 0, _bitmap.Width, _bitmap.Height));
            var lineList = this.Helpers.GetPatternsFromBitmap(parentPt, 500, 1, true, 10, 10);
            if (lineList.Count > 0)
            {
                foreach (var line in lineList)
                {
                    var wordList = this.Helpers.GetPatternsFromBitmap(line, 50, 10, false, 10, 10);
                    if (!(wordList?.Count > 0)) continue;
                    foreach (var word in wordList)
                    {
                        var charList = this.Helpers.GetPatternsFromBitmap(word, 5, 5, false, 40, 40);
                        if (!(charList?.Count > 0)) continue;
                        foreach (var c in charList)
                        {
                            c.GetPatternBoundaries(5, 5, false, 40, 40);
                            _drawBitmap = c.DrawChildPatternBoundaries(_drawBitmap);
                            c.OriginalBmp.Save(@"PATH");
                        }
                    }
                }
            }
            PbPreview.Source = this.Helpers.BitmapToImageSource(_drawBitmap);
        }
    }
}
