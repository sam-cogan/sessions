---?image=sqlAgent/images/9229214173_562de0740c_z.jpg
@size[2em](SQL Agent in the Cloud)

@size[0.5em](SQl Saturday Manchester - 14th July 2018)  
@size[0.5em](Sam Cogan)


---
@div[left]
@size[3em](Sam Cogan)


Solutions Architect  
  
Willis Towers Watson  <br/><br/>

Microsoft Azure MVP  

<br/><br/>

@fa[chrome] @color[#e49436](samcogan.com)  

@fa[twitter] @color[#e49436](@samcogan)  

@fa[github] @color[#e49436](sam-cogan)  

@divend

@div[right]

![Sam Cogan](sqlAgent/images/Sam_Cogan_new_cropped.jpg)

@divend

---?image=sqlAgent/images/sqliaas_sql_server_cloud_continuum.png&size=80% 80%&position=bottom


@title[Shifting to PaaS]


### The Shift to Platform as a Service

---

### SQL Agent Alternatives

* SQL Agent is not present in Azure SQL
* Alternatives:
    * IaaS Virtual Machine with SQL
    * Azure SQL Managed Instance
    * @color[orange](Elastic Database Jobs)
    * @color[orange](Azure Automation)
    * @color[orange](Azure Functions)


---?image=sqlAgent/images/AzureSQLStretchDatabase_COLOR.svg&opacity=20&size=80% 80%&position=right bottom
### Elastic Database Jobs


* Run jobs in parallel across databases
* Jobs written in T-SQL
* Supports SQL Databases, Servers and Elastic Pools
* Jobs can run across subscription
* One-off or scheduled execution
* Performance, cost and scale depends on Job DB
* @color[orange](Currently in Preview)
* Administration is all PowerShell or T-SQL (no GUI)

@size[1.2em](Cost:) @color[orange](£10 - £3000 per month)

---?image=sqlAgent/images/conceptual-diagram.png&position=bottom 10px &size=80% 80%

---?image=sqlAgent/images/Azure-Automation_COLOR.svg&opacity=20&size=80% 80%&position=right
### Azure Automation

* PowerShell only
* Run on schedule or webhook
* Delayed start
* Secure variable storage
* 3-hour timeout (with resume)
* No output binding
* Supports Hybrid Workers

@size[1.2em](Cost:) @color[orange](500 Minutes Free, then £0.002/minute )

---?image=sqlAgent/images/AzureFunctions_COLOR_LARGE.svg&opacity=20&size=80% 80%&position=right
### Azure Functions

* Multiple Languages, some experimental
* Multiple triggers, Input and output bindings
* Nearly instant startup
* Autoscaling and dynamic memory
* 5-minute timeout by default
* Supports Managed Service Identity

@size[1.2em](Cost:) @color[orange](large free grant, then £0.000012/GB-s and £0.15 per million executions )

---
### Which To Use?


<table class="compare-table">
<thead><tr class="compare-table-header"><th></th><th>Elastic Jobs</th><th>Automation</th><th>Functions</th></tr></thead><tbody>
 <tr><td class="compare-table-header">Languages</td><td>T-SQL</td><td>PowerShell</td><td>Multiple Languages</td></tr>
 <tr><td class="compare-table-header">Job Length</td><td>Long Running Jobs</td><td>Long Running Jobs</td><td>Short Jobs</td></tr>
 <tr><td class="compare-table-header">Triggers</td><td>Manual or Time Trigger</td><td>Manual, Webhook or Timer Trigger</td><td>Many Triggers</td></tr>
 <tr><td class="compare-table-header">Input & Output</td><td>DB Input & Output</td><td>Manual Input & Output</td><td>Many Input & Output Bindings</td></tr>
 <tr><td class="compare-table-header">Targets</td><td>Multiple concurrent targets</td><td>Build your own concurrency</td><td>Build your own concurrency</td></tr>
 <tr><td class="compare-table-header">Startup</td><td>Fast start</td><td>Delayed Start</td><td>Instant Start</td></tr>
 <tr><td class="compare-table-header">Resource Access</td><td>Azure SQL Only</td><td>Hybrid Workers</td><td>Web app options</td></tr>
 <tr><td class="compare-table-header">Scale</td><td>Scale on Job DB size</td><td>No scaling</td><td>Dynamic scaling</td></tr>
  <tr><td class="compare-table-header">Cost</td><td>Database SKU</td><td>Per Job (free grant)</td><td>Per second & memory (free grant)</td></tr>
</tbody></table>

---
### Advanced Functionality

@div[left]

<h4> @color[orange](Move Beyond Maintenance)</h4>

<ul>
<li> Scaling</li>
<li> Backup/Export</li>
<li> Provisioning</li>
</ul>


@divend

@div[right]

<h4> @color[orange](Integration)</h4>
<ul>
<li>Event Grid </li>
<li> Azure Scheduler </li>
<li> Azure Monitor/Log Analytics/App Insights </li>
<li> 3rd Party Monitoring Systems</li>
<li> Anything that can make a post request </li>
</ul>


@divend

---?image=sqlAgent/images/1447024668_8bd1d355a1_z.jpg
### Questions


---

#### @color[orange](Resources)

* Slides - http://bit.ly/2NHKEOE
* Code Samples - http://bit.ly/2L0WYeu
 
 <br/>

#### @color[orange](Image Atrribution)

* @size[0.8em]([What ?](https://flickr.com/photos/wonderferret/1447024668 "What ?") flickr photo by [wonderferret](https://flickr.com/people/wonderferret) shared under a [Creative Commons (BY) license](https://creativecommons.org/licenses/by/2.0/))
* @size[0.8em]([Clouds](https://flickr.com/photos/jonolist/9229214173 "Clouds") flickr photo by [jonolist](https://flickr.com/people/jonolist) shared under a [Creative Commons (BY-SA) license](https://creativecommons.org/licenses/by-sa/2.0/))