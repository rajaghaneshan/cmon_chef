class FormatString {
  static List<String> formatInstructions(String ins) {
    String instructions = ins
        .replaceAll('<ol>', '')
        .replaceAll('<li>', '')
        .replaceAll('</li>', '')
        .replaceAll('</ol>', '');
    List<String> instructionList = instructions.split('. ');
    return instructionList;
  }

  static String formatOccasions(List occ) {
    String occasions = occ.join(' / ');
    return occasions;
  }

  static List<String> getIngredients(List<dynamic> instructions) {
    List<String> ingredients = [];
    try {
      instructions[0]['steps'].forEach((element) {
        element['ingredients'].forEach((e) {
          // print(e['name']);
          ingredients.add(e['name']);
        });
      });
    } catch (e) {
      print(e);
    }
    return ingredients.toSet().toList();
  }
}
