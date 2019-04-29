public class StringFormatter {
    public static String noDecimals(Decimal input) {
        return input.setScale(0, System.RoundingMode.DOWN).format();
    }
    
    public static String defaultFormatted(Date input) {
        Datetime dt = Datetime.newInstance(input.year(), input.month(), input.day());
        return dt.format('dd.MM.YYYY');
    }
}