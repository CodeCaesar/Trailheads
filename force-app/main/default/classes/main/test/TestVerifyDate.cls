@IsTest
private class TestVerifyDate {
  @IsTest
  static void testCheckDatesLessThan30() {
    date date1 = date.newInstance(1990, 11, 21);
    date date2 = date1.addDays(2);
    VerifyDate.CheckDates(date1, date2);
  }
  @IsTest
  static void testCheckDatesMoreThan30() {
    date date1 = date.newInstance(1990, 11, 21);
    date date2 = date1.addDays(40);
    VerifyDate.CheckDates(date1, date2);
  }

  @IsTest
  static void testCheckDatesPastMoreThan30() {
    date date1 = date.newInstance(1990, 11, 21);
    date date2 = date1.addDays(40);
    VerifyDate.CheckDates(date2, date1);
  }
  @IsTest
  static void testCheckDatesPast() {
    date date1 = date.newInstance(1990, 11, 21);
    date date2 = date1.addDays(2);
    VerifyDate.CheckDates(date2, date1);
  }
}
