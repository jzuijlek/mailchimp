/**
*
* @file  mailchimp.cfc
* @author Jonathan van Zuijlekom
* @description MailChimp API v2.0 wrapper
*
*/

component {

	public any function init(required string apikey) {
		variables.apikey = arguments.apikey;
		variables.dc = listLast(variables.apikey,"-");
		variables.endPoint = "https://" & variables.dc & ".api.mailchimp.com/2.0/"
		return this;
	}

	private any function call(required string uri, struct params={}) {
		arguments.params.apikey = variables.apikey;
		/* create new http service */
		var httpService = new http();
		/* set attributes using implicit setters */
		httpService.setMethod("post");
		httpService.setCharset("utf-8");
		httpService.setUrl(variables.endPoint & arguments.uri & ".json");
		httpService.addParam(type="header",name="Content-Type", value="application/json");
		httpService.addParam(type="body", value=serializeJSON(arguments.params));
		/* make the http call to the URL using send() */
		var result = httpService.send().getPrefix();
		if (IsJSON(result.filecontent)) {
			return deserializejson(result.filecontent);
		}
 	}

	public any function OnMissingMethod (required string methodName, required struct methodArguments) {
		if (listLen(arguments.methodName,"_") == 2) {
			return call(replace(arguments.methodName,"_","/"),arguments.methodArguments);
		}

	}

}
