const String jsonExample = """
{
  "date": "YYYY-MM-DD",
  "items": [
    {
      "name": "item_name_1",
      "price": number
    },
    {
      "name": "item_name_2",
      "price": number
    }
   ...
  ],
  "total": number
}
""";

const String xmlExample = """
<receipt>
  <date>YYYY-MM-DD</date>
  <items>
    <item>
      <name>item_name_1</name>
      <price>number</price>
    </item>
    <item>
      <name>item_name_2</name>
      <price>number</price>
    </item>
    ...
  </items>
  <total>number</total>
</receipt>
""";