String test = "2012-05-07 14:24:00";
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");

try {
  println(sdf.parse(test));
} catch(Exception e) {
  
}
