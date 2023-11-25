const {MongoClient}=require('mongodb');
let dbconnect;
module.exports={
    ConnectTodb:(cb)=>{
        MongoClient.connect('mongodb://127.0.0.1:27017/Quiz_db')
        .then((client)=>{
            dbconnect=client.db();
            return cb();
        }).catch(
            (err)=>{
                return cb(err);
            }
        )
    },
    
    getdb:()=>dbconnect

};