const Discord = require("discord.js")
const client = new Discord.Client()

const discordToken = process.env.DISCORD_TOKEN

client.on("ready", () => {
  console.log(`Logged in as ${client.user.tag}! Welcome.`)
})

client.on("message", messageIn => {
  if (messageIn.content.toLowerCase() === "ping" || messageIn.content === "Hi") {
    messageIn.reply("Welcome, you connected successfully");
  }

  else if (messageIn.content.toLowerCase() === "!business-requirements") {
    messageIn.reply("Check the channel Labeled Business Requirements");
  }

  else if (messageIn.content.toLowerCase() === "!commands") {
    messageIn.reply("Check the channel Labeled Commands");
  }
})

///////////////////////////////////////////////
////////////    DISCORD RESPONSE   ////////////
////////////     HANDLE COMMANDS   ////////////
///////////////////////////////////////////////
const { MessageEmbed } = require("discord.js");

const mysql = require("mysql");

const conn = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});
conn.getConnection((err) => {
  if (err) {
    console.log(err);
  } else {
    return console.log(`Connected to ${process.env.DB_NAME}`);
  }
});

///////////////////////////////////////////////
////////////       COMMAND 1       ////////////
///////////////////////////////////////////////
client.on("message", (messageIn) => {


  if (messageIn.content == "!userBlogPost") {
    //1. FIND THE USERS WHO HAVE MADE CONTRIBUTIONS TO AT LEAST 2 BLOG POSTS 
    conn.query(
      `SELECT u.first_name AS FirstName, u.last_name AS LastName, u.user_id AS UserId, 
        COUNT(b.user_id) 
        AS userBlogPosts 
        FROM Users u
        INNER JOIN blog b ON u.user_id = b.user_id
        GROUP BY u.user_id 
        HAVING COUNT(b.user_id)>=2;`,
      (err, results) => {
        const output = Object.values(JSON.parse(JSON.stringify(results)));

        for (let key in output) {

          const obj = output;

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`);

          }
          let object = output[key];

          console.log(output);

          if (err) {
            console.log("There was an Error: " + err);

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`userBlogPost` Result(s)")
              .addFields({
                name: `Name of User: ${object.FirstName} ${object.LastName} 
                        Id: ${object.UserId}`,
                value: `Amount of Blog Contributions: ${object.userBlogPosts}`,
                inline: true,
              });
            messageIn.channel.send(messageFormatToUser);
          }
        }
      }
    );
  }


  ///////////////////////////////////////////////
  ////////////       COMMAND 2       ////////////
  ///////////////////////////////////////////////

  if (messageIn.content == "!avgBlogAmount") {
    //2.  FIND THE AVG BLOG AMOUNT FOR USERS 
    conn.query(
      `SELECT u.first_name AS firstName, u.last_name AS lastName, u.user_id AS UserId, AVG(b.blogAmount) AS avgBlogAmount 
        FROM Users u
        INNER JOIN blog b ON u.user_id = b.blog_id
        GROUP BY u.user_id;`,
      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`avgBlogPost` Reult(s)")
              .addFields({
                name: `Name of User: ${object.firstName} ${object.lastName}
                              Id: ${object.UserId}`,
                value: `Total Average Blogs: ${object.avgBlogAmount}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }


  ///////////////////////////////////////////////
  ////////////       COMMAND 3       ////////////
  ///////////////////////////////////////////////

  if (messageIn.content == "!adminAndAds") {
    // 3.	SELECT list of admin who are responsible for controlling specific advertisements
    conn.query(
      `SELECT DISTINCT ad.name AS adminName, ad.rank AS adminRank, ad.admin_id AS adminId, ad.advertisement_id AS adId
  FROM admin ad
  JOIN ( SELECT advertisement_id 
           FROM advertisements
          LIMIT 5
       ) adv
    ON adv.advertisement_id;  `,
      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`adminAndAds` Results(s)")
              .addFields({
                name: `Name: ${object.adminName}  
                              Rank: ${object.adminRank} 
                              Id: ${object.adminId}`,
                value: `Specific Ad Id: ${object.adId}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }

  ///////////////////////////////////////////////
  ////////////       COMMAND 4       ////////////
  ///////////////////////////////////////////////


  if (messageIn.content == "!primeSubscriptionSince") {
    // 4. use stored function to Find Prime account members date they began subscription 
    //using select statment for ease of access and printing-- Function works in workbench 
    conn.query(
      `Select prime_account_id AS primeAccountId, subrscription_length(subscription_duration) as 'subscribedSince' from Prime_Account; `,
      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`primeSubscription` Result(s)")
              .addFields({
                name: `Account ID: ${object.primeAccountId}`,
                value: `Subscription Start Year: ${object.subscribedSince}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }


  ///////////////////////////////////////////////
  ////////////       COMMAND 5       ////////////
  ///////////////////////////////////////////////


  if (messageIn.content == "!categoryCount") {
    // 5. use stored function to show categories when category amount is greater than 4 
    //using select statment for ease of access and printing-- Function works in workbench 
    conn.query(
      `Select category_id AS 'categoryId', type AS 'type', categoryCount(category_count) AS 'categoryCount'
          FROM category
          WHERE category_count > 4;`,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`categoryCount` Result(s)")
              .addFields({
                name: `CategoryType:     ${object.type} 
                                 ID: ${object.categoryId}  `,
                value: `CategoryCount:    ${object.categoryCount}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }

  ///////////////////////////////////////////////
  ////////////       COMMAND 6       ////////////
  ///////////////////////////////////////////////


  if (messageIn.content == "!rolesOfAccounts") {
    // 6.	Use stored procedure to find the accounts with roles 
    //using select statment for ease of access Procedure works in workbench 
    conn.query(
      `SELECT a.account_id AS accountIdWithRoles, rol.theme AS theme, rol.conditon AS conditions
        FROM Account a 
        INNER JOIN Roles rol
        ON rol.account_id = a.account_id; `,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`rolesOfAccounts` Result(s)")
              .addFields({
                name: `CategoryType:     ${object.theme} 
                                 ID: ${object.accountIdWithRoles}  `,
                value: `CategoryCount:    ${object.conditions}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }

  ///////////////////////////////////////////////
  ////////////       COMMAND 7       ////////////
  ///////////////////////////////////////////////


  if (messageIn.content == "!devLifetime") {
    //7.	use stored procedure to find the devices in runOns table with lifetime greater than 85  
    //using select statment for ease of access Procedure works in workbench 
    conn.query(
      `SELECT rOn.devices_id AS deviceId, dev.type AS 'type', dev.lifetime AS lifetime
        FROM Runs_On rOn 
        INNER JOIN devices dev
        ON dev.devices_id = rOn.runs_on_id
        HAVING dev.lifetime > 85; `,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`devLifetime` Result(s)")
              .addFields({
                name: `DeviceType:     ${object.type} 
                                 ID: ${object.deviceId}  `,
                value: `LifeTime:                ${object.lifetime}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }

  ///////////////////////////////////////////////
  ////////////       COMMAND 8       ////////////
  ///////////////////////////////////////////////

  //////// SELECT ARTICLES //////////////////////
  if (messageIn.content == "!showArticles") {
    //8a.	Update article id from monitors table  
    conn.query(
      `SELECT article_id AS previousArticleId, monitors_id AS monitorsId FROM Monitors ;  `,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`Show Articles` Result(s)")
              .addFields({
                name: `Monitors ID:     ${object.monitorsId}  `,
                value: `Current ArticleID:    ${object.previousArticleId}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }

  ///////  UPDATE ARTICLES   ////////////////////
  // if(messageIn.content == "!updateArticles"){
  //     //8b.	Update article id from monitors table  (QUERY WONT RUN HERE BUT DOES IN WORKBENCH..IMPPROPER FORMAT? )
  //       conn.query(
  //         `UPDATE? Monitors mon 
  //         INNER JOIN articles art
  //         SET mon.article_id = 8 
  //         WHERE art.article_id = 3;  `,

  //         function(err, results) {
  //               const output = Object.values(JSON.parse(JSON.stringify(results)))

  //               for (let key in output) {

  //                   const obj = output

  //                   if (Object.hasOwn(obj, key)) {

  //                       console.log(`obj.${key} = ${obj[key]}`)

  //                   }
  //                   let object = output[key]

  //                   console.log(output)

  //                   if (err) {
  //                       console.log("There was an Error: " + err)

  //                   } else {

  //                       const messageFormatToUser = new MessageEmbed()
  //                           .setTitle("`Updating Articles`")
  //                           .addFields({
  //                               name: `run !showUpdatedArticles For changes `,
  //                               value: ``,
  //                               inline: true,
  //                           })
  //                       messageIn.channel.send(messageFormatToUser)
  //                   }
  //               }
  //           }
  //       );
  //   }

  /////   SHOW UPDATED ARTICLES /////////////////

  // if(messageIn.content == "!showUpdatedArticles"){
  //     //8c.	Update article id from monitors table  
  //       conn.query(
  //         `SELECT article_id AS newArticleId, monitors_id AS monitorsId FROM Monitors ;  `,

  //         function(err, results) {
  //               const output = Object.values(JSON.parse(JSON.stringify(results)))

  //               for (let key in output) {

  //                   const obj = output

  //                   if (Object.hasOwn(obj, key)) {

  //                       console.log(`obj.${key} = ${obj[key]}`)

  //                   }
  //                   let object = output[key]

  //                   console.log(output)

  //                   if (err) {
  //                       console.log("There was an Error: " + err)

  //                   } else {

  //                       const messageFormatToUser = new MessageEmbed()
  //                           .setTitle("`Updated Articles` Result(s)")
  //                           .addFields({
  //                               name: `Monitors ID:     ${object.monitorsId}`,
  //                               value: `Updated ArticleID:    ${object.newArticleId}`,
  //                               inline: true,
  //                           })
  //                       messageIn.channel.send(messageFormatToUser)
  //                   }
  //               }
  //           }
  //       );
  //   }

  if (messageIn.content == "!upvoteCount") {
    // 9.	Get the list of users with more than 5 upvotes and has upvote type as “good” 
    conn.query(
      `SELECT upv.upvote_id AS upvoteID,  MAX(upv.upvote_count) AS UpVoteCount 
        FROM Upvote upv
        INNER JOIN Users u ON upv.upvote_id = u.user_id
        WHERE upv.upvote_count > 5 && upv.upvote_type="GOOD"
        GROUP BY  u.user_id
        HAVING MAX(upv.upvote_count)
        ORDER BY UpVoteCount DESC; `,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`Upvote Count` Result(s)")
              .addFields({
                name: `UpvoteID:       ${object.upvoteID}  `,
                value: `UpvoteCount: ${object.UpVoteCount}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }

  if (messageIn.content == "!multimedia") {
    // 10. Use sub query to generate multimedia ID whose ID is greater than 1 
    conn.query(
      `Select multimedia_id AS multimediaID, type AS multimediaType FROM multimedia mul
WHERE multimedia_id IN
(SELECT multimedia_id FROM Monitors WHERE multimedia_id > 1); `,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`Multimedia` Result(s)")
              .addFields({
                name: `Multimedia ID:       ${object.multimediaID}  `,
                value: `Multimedia Type: ${object.multimediaType}`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }


  if (messageIn.content == "!limitedAccountPeriod") {
    // 11.Find limited account accounts who has a limited account period less than 45 days
    conn.query(
      `SELECT lim.limited_account_period AS limitedAcoountPeriod, lim.account_id AS accountID
        FROM Limited_Account lim
        INNER JOIN Users u ON lim.limited_account_id = u.user_id
        GROUP BY lim.account_id, lim.limited_account_id
        HAVING MIN(lim.limited_account_period) < 45;  `,

      function(err, results) {
        const output = Object.values(JSON.parse(JSON.stringify(results)))

        for (let key in output) {

          const obj = output

          if (Object.hasOwn(obj, key)) {

            console.log(`obj.${key} = ${obj[key]}`)

          }
          let object = output[key]

          console.log(output)

          if (err) {
            console.log("There was an Error: " + err)

          } else {

            const messageFormatToUser = new MessageEmbed()
              .setTitle("`Limited Acoount Period` Result(s)")
              .addFields({
                name: `Account ID: ${object.accountID}  `,
                value: `Limited Account Period: ${object.limitedAcoountPeriod} days`,
                inline: true,
              })
            messageIn.channel.send(messageFormatToUser)
          }
        }
      }
    );
  }


});


client.login(discordToken)
