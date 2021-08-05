# Covid19Project (Case of Turkey)

![indir](https://user-images.githubusercontent.com/52802861/128412536-d0056fd4-a23d-4684-8c8c-241e1da9b41c.jpg)

Goal of this project is to understand covid 19 pandemic vaccination and death percentages by countries. Several queries have been developed to understand the data. There has been some some interesting observations are obtained by queries. 

Most of the observations are spesifically includes Turkey since I'm a Turkish guy. ![1360](https://user-images.githubusercontent.com/52802861/128416453-64f3047c-1a06-451c-8c36-9f531b7611d8.png)

First one is from stored procedure called "Turkey Death" As you can see in the below picture of row if you got Covid in Turkey in 04.08.2021 you have a %0.88 chance to get die from it.

![04 08 2021-DeathPercentage](https://user-images.githubusercontent.com/52802861/128416761-d026eab1-92d8-4275-8d2c-f9d06240e04e.png)

Query #4 clearly shows two things about Turkey, Firstly, during the year 2020, 2,208,652 people have been diagnosed by COVID-19 in Turkey and 20,881 people have died and secondly, the official death percentage was %0.94 at the end of the year. Please see below the results from the table view.

![31 12 2020-DeathPercentRow](https://user-images.githubusercontent.com/52802861/128427721-87f22e36-5c3d-46a1-8e4c-024f13af1696.png) --> end of the year 2020

When we're curious about the infection percentage of the population of Turkey as of 04.08.2021, the infection percentage is around %6.9 as a result of the obtained table from Query #5.

![04_08_2021_InfectionPercentage](https://user-images.githubusercontent.com/52802861/128428595-d247e621-647d-4929-a549-0be61f3c181c.png)

Among 222 countries Turkey is at 49th place in infection rate compared to the population by the date of 04.08.2021. This result has been found by Query #6.

![Rank_of_Turkey](https://user-images.githubusercontent.com/52802861/128429232-1cf170b6-e515-4e83-b125-bf0609a816c4.png)

Among 222 countries Turkey is at 19th place in death rate compared to the population with 51,767 dead people by the date of 04.08.2021. This result has been found by Query #7.

![Rank_of_Turkey(Death)](https://user-images.githubusercontent.com/52802861/128429620-f62f0562-5b71-47b1-93c8-cfbdd9ce75ee.png)

According to Query #8, 426,290 people have died from COVID-19 in the Asia continent as the date of 04.08.2021 and around %12 of this died in Turkey.

![Asia_Death](https://user-images.githubusercontent.com/52802861/128430556-fd0449b9-73bf-4374-b63c-3325ac0544b0.png)

According to Query #9 total death count is 4,247,967 in the world as of 04.08.2021 and around %1.21 of this died in Turkey

![Total_Death](https://user-images.githubusercontent.com/52802861/128430892-0179b55c-92bf-49d7-a995-c7a24363e617.png)

As you know at end of the year 2020 vaccination of people are started all around the world. Turkey has started vaccinating people in 14.01.2021. They did a tremendous job in the first couple of days according to the data set. I mean 279452 people have been vaccinated on the first day. Please see Query #10

![First_Vac_Turkey](https://user-images.githubusercontent.com/52802861/128431749-a2a1de3d-7285-4a42-a9ec-dade4bc65585.png)

I have also used a CTE to calculate the percentage of people who were vaccinated but I have to say I don't find the results reliable. The reason for this is each dose is entered individually into the data set. However, the same person is normally vaccinated in two doses. Moreover even three doses have been vaccinated particularly in Turkey due to the "Sinovac Crisis". In other words, while the same person is vaccinated twice population remains the same so the vaccination rate increases unreasonably. Still, I wanted to share the CTE query results with you. Please see them below.

![Vac_rate_of_Turkey,](https://user-images.githubusercontent.com/52802861/128432847-2b49d4da-2902-46b5-a9a1-a58b01c91b9b.png)

As you can see above %87 of people in Turkey are shown as vaccinated which is only technically true, not true healthwise.












