import app from '../index.js';
import request from 'supertest';
import { generateToken } from '../utils/generateToken.js';
import jwt from "jsonwebtoken";


describe("User Controller", () => {

    const loginApi = "/api/users/auth";
    const testUser = {
        email: "john2@gmail.com",
        password: "john123"
    };

    



    describe('Auth User Function', () => {

        describe("given the email and password are valid", () => {
            

            test("should respond with a 201 status code", async () => {
                const res = await request(app).post(loginApi).send(testUser)
                expect(res.statusCode).toBe(201)
            })

            test("should specify json in the content type header", async () => {
                const res = await request(app).post(loginApi).send(testUser)
                expect(res.headers['content-type']).toEqual(expect.stringContaining("json"))
            })

            test("response has userId, username and firstname", async () => {


                const res = await request(app).post(loginApi).send(testUser)
                expect(res.body.userId).toBeDefined()
                expect(res.body.username).toBeDefined()
                expect(res.body.firstname).toBeDefined()
            })
        })

        describe('when the username and password is missing', () => {

            test("should respond with a status code of 400", async () => {

                const bodyData = [
                    { email: "john2@gmail.com" },
                    { password: "john123" },
                    {}
                ]

                for (const body of bodyData) {
                    const res = await request(app).post(loginApi).send(body)
                    expect(res.statusCode).toBe(400)
                }

            })
        })

        


        // it('should return a 400 status code for invalid credentials', async () => {
        //     // Mock getUserByEmail function (user not found)
        //     getUserByEmail.mockResolvedValue([]);

        //     const response = await request(app)
        //         .post('/api/users/auth')
        //         .send({ email: 'test@example.com', password: 'password' });

        //     // Assert the response
        //     expect(response.status).toBe(400);
        //     expect(response.text).toBe('Invalid credentials');
        // });


        
    });

    

    // describe("Update user profile function", async () => {

    //     const res = await request(app).put()
    // })

    describe('Get User Profile Function', () => {

        const userDetailApi = "/api/users/profile"

        test("Should generate error when called without JWT token" , async () => {
            const res = await request(app).get(userDetailApi);

            expect(res.statusCode).toBe(401);
        })

        test('when user info is requested', async () => {

            // Generate a test JWT token with a known payload
            const payload = { username: 'john2@gmail.com' };
            const testToken = jwt.sign(payload, process.env.JWT_SECRET);

            const res = await request(app).get(userDetailApi).set('Cookie', [`jwt=${testToken}`]);
            
            expect(res.statusCode).toBe(200)
            expect(res.body.Username).toBeDefined()
            expect(res.body.UserID).toBeDefined()
        })
    })



});
