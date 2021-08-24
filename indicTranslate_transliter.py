import numpy as np
import matplotlib.pyplot as plt  
import easyocr
from fairseq import checkpoint_utils, distributed_utils, options, tasks, utils
from indicTrans.inference.engine import Model
from polyglot.text import Text
import gradio as gr
from PIL import Image


class KannadaToHindi :
  def __init__(self):
    self.reader = easyocr.Reader(['kn','en']) # need to run only once to load model into memory
    self.indicm2m_model = Model(expdir='/workspace/app/m2m')


  def getTextFromImage(self, image_file):
    reader = easyocr.Reader(['kn','en']) # need to run only once to load model into memory
    result = reader.readtext(image_file, detail = 0)
    return result

  def cleanTransliterText(self, transliter_text):
    blank = ['',"", " ", ' ', '\t']
    s_list = []
    for x in transliter_text:
      if x not in blank:
        s_list.append(x)
    return s_list

  def getTransliterredText(self,text_from_image):
    image_text = str(text_from_image)
    text = Text(image_text)
    transliter_text = text.transliterate("hi")
    trans_str = " ".join(self.cleanTransliterText(transliter_text))
    return trans_str

  def TranslateKannadaImageToHindi(self, kannada_img_file):
    text_from_image = self.reader.readtext(kannada_img_file, detail = 0)
    transliterred_result = self.getTransliterredText(text_from_image)
    translated_result = self.indicm2m_model.batch_translate(text_from_image, 'kn', 'hi')
    return translated_result, transliterred_result

# kannada_img_file = '/workspace/app/data/kannada_04.jpg'
"""
Let's initialize the model so that use is quicker
"""
ocr_file_name = "ocr_image.jpg"
transcode = KannadaToHindi()
# translated, translittered = transcode.TranslateKannadaImageToHindi(kannada_img_file)
# print(translittered)
# print(translated)


def translate_transliter(kannada_img_numpy):
  # kannada_img_file.save("ocr_file","JPEG")
  # input_file = "ocr_file.JPEG"
  im = Image.fromarray(kannada_img_numpy).save(ocr_file_name)
  translated, translittered = transcode.TranslateKannadaImageToHindi(ocr_file_name)
  return translated, translittered



iface = gr.Interface(fn=translate_transliter,
            title = "Kannada to Hindi Translate",
            description = "Translate kannada text from images to hindi",
            article = "Upload image containing kannada text",
            inputs=gr.inputs.Image(),
            outputs=["text", "text"],
            server_port=7860,
            server_name="0.0.0.0")

iface.launch()
