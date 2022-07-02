int calculateSumPrice(List<Map<String, dynamic>> data) {
  return data.fold(
    0,
    (previousValue, element) =>
        previousValue +
        int.parse(element["varianteModel"]["price"].toString()) *
            int.parse(
              element["quantity"].toString(),
            ),
  );
}

int calculateSumTax(List<Map<String, dynamic>> data) {
  return data.fold(
    0,
    (previousValue, element) =>
        previousValue +
        int.parse(element["varianteModel"]["tax"].toString()) *
            int.parse(
              element["quantity"].toString(),
            ),
  );
}
