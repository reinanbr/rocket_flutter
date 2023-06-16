String brockLine(String text, int limit) {
  var new_text_list = text.split(' ');
  if (text.split(' ').length / limit > 1) {
    var i = 0;
    for (var _ in text.split(' ').sublist(limit)) {
      if (i % limit == 0) {
        new_text_list.insert(i+limit, '\n');
      }
      i = i + 1;
    }
  }
  var new_word = new_text_list.join(' ').replaceAll('\n ', '\n');
  return new_word;
}


void main() {
  var text = 'o sexo salva vidas! Porém, é preciso criar uma empresa antes!';
  print(brockLine(text,4));
}
