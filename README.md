aeolus-logger
=============
This repository contains the code developed during the "__Aeolus Logger__" project.

About
-----
The "__Aeolus Logger__" project is about the implementation of a __logging system__ and it's integration with _Emerson_ cooling units, so that it can be used to monitor the environmental conditions of the __cluster room__ inside the building of the [Computer Science and Engineering Department](http://cse.uoi.gr) (CSED), [University of Ioannina](http://uoi.gr). The __Aeolus__ server monitors the __status__ of the _Emerson_ units and __alarms__ the faculty if any __abnormal__ conditions are observed. Currently, the server is deployed in the data center of [CSED](http://cse.uoi.gr), while versions under development are deployed in other infrastructures (e.g. [~okeanos IaaS](https://okeanos.grnet.gr/about/what/) by [Greek Research and Technology Network](http://www.grnet.gr/)).


Screenshots
-----------

<br>_Main Page_<br>
![Main Page](./images/aeolus_main_page.png)

<br>_Status Report_<br>
![Status Report](./images/aeolus_status_report.png)

<br>_Measurement Report_<br>
![Measurement Report](./images/aeolus_measurement_report.png)

<br>_Graph Report_<br>
![Graph Report](./images/aeolus_graph_report.png)

<br>_Sample graph (1 Hour Temperature Log - Emerson #3)_<br>
![Sample Graph](./images/demo_temp_1hour.png)

<br>_Sample graph (1 Hour Temperature Log - Emerson #3 & #4)_<br>
![Sample Graph](./images/demo_temp_1hour_dual.png)

<br>_Sample graph (1 Month Temperature Log - Emerson #3 & #4)_<br>
![Sample Graph](./images/demo_temp_4week_dual.png)

<br>_Sample graph (1 Month Humidity Log - Emerson #4)_<br>
![Sample Graph](./images/demo_hum_4week.png)

<br>_Email Alert_<br>
![Email Alert example](./images/aeolus_email_alert.png)

<br>_Website setup has finished message_<br>
![Website setup has finished message](./images/aeolus_setup.png)

<br>_Website setup has finished with errors message_<br>
![Website setup has finished with errors message](./images/aeolus_setup_errors.png)

<br>Contents of aeolus.log after installation<br>
![Contents of aeolus.log after installation](./images/aeolus_log.png)


W3C valid website
-----------------
The whole website is HTML5 and CSS3 valid, while the RSS feed has been validated too by [W3C](http://www.w3.org/).<br>

__Validators Used__:
 * [for HTML5](https://validator.w3.org/)
 * [for CSS3](https://jigsaw.w3.org/css-validator/)
 * [for RSS](https://validator.w3.org/feed/)

<br>
<img src="./images/badge-w3c-valid-html5.png" width="150">
<img src="./images/badge-w3c-valid-css3.png" width="150">
<img src="./images/badge-w3c-valid-rss2.png" width="150">

Demo Website
------------
[Static website](http://cse.uoi.gr/~gzachos/aeolus-logger) (Hosted in [cse.uoi.gr](http://cse.uoi.gr/en/index.php?menu=m1))

Licence
-------
[GNU GENERAL PUBLIC LICENSE // Version 2, June 1991](LICENSE)

Developer
--------
[George Z. Zachos](http://cse.uoi.gr/~gzachos)
