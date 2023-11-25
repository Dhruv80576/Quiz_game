const express=require('express');
const profile=express.Router();
const {ObjectId}=require('mongodb');

profile.get('/get_questions',(req,resp)=>{
    console.log('received');
    let questions=[];
    datab.collection('questions').find().sort().forEach(ques => {
       questions.push(ques)
    })
    .then(()=>{
        resp.json(questions).status(200);

        console.log("response sent")}).catch((err)=>{
            resp.json(err)
        });
});
profile.get('/role/:email',async(req,resp)=>{
    var user=await datab.collection('users').findOne({email:req.params.email});
    resp.send(user.role);
})
profile.post('/add_question/:email/:password',async (req,resp)=>{
    const {ques,options,answer}=req.body;
    const user=await datab.collection('users').findOne({email:req.params.email,password:req.params.password});
    if(ques!=''&&options!=null&&answer!=null&&user){
        datab.collection('questions').insertOne(req.body).then((res)=>{
            resp.send(res);
        });
    }
    else{
        resp.json({title:"not authenticated"});
    }
})
profile.delete('/delete_ques/:email/:password/:id',async(req,resp)=>{
    console.log("delete request");
    const user= await datab.collection('users').findOne({email:req.params.email,password:req.params.password});
    if(user){
            datab.collection('questions').deleteOne({_id:new ObjectId(req.params.id)}).then((data)=>{
        console.log(data);
        resp.json(data)
    });
    }
    else{
        resp.json({title:"not authenticated"});
    }
})
module.exports= profile;