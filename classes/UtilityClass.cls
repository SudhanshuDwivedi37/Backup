public with sharing class UtilityClass {
 
 public static string getPaseHTML(string htmlText){
  string plainText = htmlText;
  
  try{
   //first replace all <BR> tags with \n to support new lines
   string result = htmlText.replaceAll('<br/>', '\n');
   result = result.replaceAll('<br />', '\n');
   result = result.replaceAll('&nbsp;', ' ');
   
   //regular expression to match all HTML/XML tags
   string HTML_TAG_PATTERN = '<[^>]+>';
   
   // compile the pattern     
   pattern myPattern = pattern.compile(HTML_TAG_PATTERN);
   
   // get your matcher instance
   matcher myMatcher = myPattern.matcher(result);
   
   //remove the tags     
   plainText = myMatcher.replaceAll('');

  }
  catch(Exception ex){
   system.debug(ex.getMessage());
  }
  return plainText;
 }
}