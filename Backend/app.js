const express=require('express');
const {ConnectTodb,getdb}=require('./database');
const {ObjectId}=require('mongodb');
const app=express();
const PORT=process.env.PORT||3000;
const router=require('./routes/auth');
const profile=require('./routes/profile');
app.use(express.json());

ConnectTodb((err)=>{
    if(!err){
        app.listen(PORT,()=>{
            console.log("App is listening on Port "+PORT);
        })
        global.datab=getdb();
    }
    else{
        console.log(err);
    }
});


// app.post('/new_ques',(req,res)=>{
//     datab.collection('questions').insertOne(req.body).then(
//         ()=>{
//             res.json(req.body);
//         }
//     )
// })
app.use('/auth',router);
app.use('/',profile);
// app.delete('/delete_ques/:id',(req,resp)=>{
//     console.log("delete request");
//     datab.collection('questions').deleteOne({_id:new ObjectId(req.params.id)}).then((data)=>{
//         console.log(data);
//         resp.json(data)
//     });
// })
