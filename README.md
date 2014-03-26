mailchimp
=========

CFML MailChimp API v2.0 wrapper

Getting Started
===============

Initialize the MailChimp wrapper with the MailChimp apikey.

	mailChimp = new mailChimp('apikey');

Now you can call any method in the API (http://apidocs.mailchimp.com/api/2.0/) by replacing the / with an _.

	campaign = mailChimp.campaigns_list();

You can also pass in extra paramters

	campaign = mailChimp.campaigns_list(filters={status="sent"},sort_field="send_time");
