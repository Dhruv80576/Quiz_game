const register= async(req,res)=>{
    console.log("received request")
    const {email,password,role}=req.body;
    if(email!==''&&password!==''&&role!=''){
        const user=await datab.collection('users').findOne({email:email});
        if(!user){
            
            datab.collection('users').insertOne(req.body).then(
            ()=>{
                res.status(200);
                console.log("Successfuly registered user...")
                res.json({title:"User Registered"});
            }
        )
        }
        else{
            res.status(401);
            res.json({title:"User already exists."});
        }
        
    }
    else{
        res.status(401);
        console.log("Error in registering user.")
    res.json({
        title:"User not registered"
    });
    }
}

const Login=async(req,res)=>{
    const {email,password}=req.body;
    const user =await datab.collection('users').findOne({email:email})
    if(!user){
        console.log('f');
        res.status(401);
        res.json({title:"User does not exists"});
    }
    else{
        const {password:actual}=user;
        if(actual===password){
            console.log('s');
            res.status(200);
            res.json({title:"User logged in.."});        }
        else{
            console.log('f');
            res.status(401);
            res.json({title:"Wrong password"});
        }
    }
}
module.exports ={register,Login};

