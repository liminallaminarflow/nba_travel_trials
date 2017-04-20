# nba_travel_trials
Just how bad was Golden State's recent stint?

*"It's truly insane. This is the worst stretch of schedule that I've ever been a part of and I've been in the league since 1988. I've never seen anything like this, eight games in eight cities with 11,000 miles." —Steve Kerr*

The NBA regular season travel schedule is famously unforgiving. Each year, each team suffers through long road trips criss-crossing the country, wreaking havoc on sleep schedules through a mix of dead-of-night late arrivals and constantly shifting time zones.

In the quote above, Steve Kerr is alluding to a particularly hellish road trip his Golden State Warriors recently struggled through. That trip started with the Warriors at home on February 25 and ended in a controversial, All-Star-free game in San Antonio on March 11. During that time, the Warriors crossed ten time zones and spent over 22 hours in the air. To even the most hardened travelers, that trip sounds atrocious. It got me wondering, though—was this specific trip unprecedented in recent NBA history, or is it merely a particularly bad trip, the sort of stint which many teams have to fight through every season?

My curiosity resulted in the [interactive graph found here](https://public.tableau.com/profile/franklin.mowshowitz#!/vizhome/scheduledistances/dash), but read on for context.

## Methodology
To answer this question, I decided to look at two metrics, by team, by season: daily in-air flight time and number of time zones crossed. For the former, I began by scraping each team’s regular-season schedule for each season from the 2004-05 through 2015-16. From there, I scraped every flight time between every combination of cities in which an NBA game has been played, including unusual circumstances like recent games played in London, Mexico City, and Baton Rouge. I matched these flight times to the NBA schedules to get a time series showing the daily flight time for each NBA team.

For the latter, I matched each game’s location up with some time zone data I gathered, making sure edge cases like Arizona’s non-participation in Daylight Savings Time was accounted for.

Since the recent Warriors trip was two weeks long, I applied a two-week moving average to the flight time graph I built. That way, if any team’s line breaches the 149.2-minute daily flight time average Golden State posted, we know that that team suffered a two-week stretch in which they were in-flight for longer than Golden State.

For the time zone graph, I applied a similar logic, but instead of using a moving average, I used a moving sum. If any team accrues more than ten time zone crossings in a two-week period, we know that team crossed more time zones than Golden State just did. I overlaid a constant line on each graph representing Golden State’s recent trip for ease of reference. If you see a team breaching GS’s line on both graphs at the same time, you can conclude that that team experienced a period of travel that crossed more time zones and spent more time in the air over a two-week period than Golden State just did.

## Findings
I built the graphs in Tableau and uploaded it into Tableau Public (click on the link above if you haven't already), so you all can explore the data yourselves, interactively, by playing with the filters and settings on the right side of the graph. You can also highlight a single team's performance by clicking on their name in the legend, or just directly clicking on the chart itself.

It appears that Kerr was not blowing smoke. During the time period investigated, just seven teams have experienced more time in the air and more time zones crossed than Golden State, and three of those trips involved playing a game in London. Here's the complete list of those teams:

Seattle, March 2007
Miami, January 2011
New York, January 2013
Atlanta, January 2014
New York, January 2015
Milwaukee, January 2015
Orlando, February 2016

So while not unprecedented, a two-week stint of Golden State's magnitude, considered from the total air time flown and number of time zones crossed, is rare, occurring less than once a season since the NBA's expansion to 30 teams in 2004.

And that’s it! I pray to god your Wednesday is more interesting than mine.
