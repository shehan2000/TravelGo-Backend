
import { generatePasswordHash, comparePasswordHash } from "../services/userService"

describe("User Service", () => {

    describe("Generating password Hash", () => {

        it('should generate a hashed password', async () => { 
            const res = await generatePasswordHash("testPassword")
            expect(res).not.toContain("testPassword")
         })

    })
     
     describe("Comparing Passwords Hashes", () => {

        it("should return false when given an password and its unequivalent hash", async () => {
            const res = await comparePasswordHash("testPassword", "nvsdvsofhewh")
            expect(res).toBeFalsy()
        })

        it("should return true when given an password and its equivalent hash", async () => {
            const password = "testPassword"
            const hash = await generatePasswordHash(password)
            const res = await comparePasswordHash(password, hash)
            expect(res).toBeTruthy()
        })
     })

     describe('getting user by email', () => {


     })

})