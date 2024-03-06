import {
    Body,
    Button,
    Container,
    Head,
    Hr,
    Html,
    Img,
    Preview,
    Section,
    Text,
  } from "@react-email/components";
  import * as React from "react";
  

  
  const baseUrl = process.env.VERCEL_URL
    ? `https://${process.env.VERCEL_URL}`
    : "";
  
  export const CorgisWelcomeEmail = () => (
    <Html>
      <Head />
      <Preview>
        Learn programming languages with AI-powered friends and gamified lessons
      </Preview>
      <Body style={main}>
        <Container style={container}>
          <Img
            src={`https://www.corgis.ai/static/emails/welcome/logo.png`}
            width="100"
            height="100"
            alt="corgis.ai"
            style={logo}
          />
          <Section>

          <Text style={paragraph}>Welcome to <a style={{color: "orange"}} href="https://www.corgis.ai">corgis.ai</a>! Your adventure is just a click away! 🚀</Text>
          <Text style={paragraph}>
            You're on the brink of starting your coding adventure with the help of our friendly corgis. 
          </Text>
          <Text style={paragraph}>
          At <a style={{color: "orange"}} href="https://www.corgis.ai">corgis.ai</a>, we transform learning into an epic quest filled with challenges and triumphs designed to elevate your coding skills.
        </Text>

          <Img src='https://www.corgis.ai/static/emails/welcome/idle.gif' width="55%" height="55%" alt="corgis.ai" style={logo} />
          <Text style={paragraph}>
          To confirm your email and unlock the gates to this adventure, please follow this magical link:
          </Text>
        </Section>
        
          <Section style={btnContainer}>
            <Button style={button} href="{{ .ConfirmationURL }}">
                Confirm your email and start the quest
            </Button>
          </Section>

          <Section>
          <Text style={paragraph}>
          Once you're in, you'll dive into gamified lessons tailored to sharpen your coding prowess and arm you for the tech world's real challenges. Get ready to unleash the power of code with corgis by your side!
          </Text>
          <Text style={paragraph}>
          We're thrilled to have you join our community. If you have questions or need a guide, our team is here to help you navigate your coding journey.
          </Text>
          <Text style={paragraph}>
          Let the adventure begin!
        </Text>
        </Section>
        
        <Text style={paragraph}>
        Best wishes, <br />
        -- The <a style={{color: "orange"}} href="https://www.corgis.ai">corgis.ai</a>  team
       
        </Text>
        <Hr  />

        </Container>
      </Body>
    </Html>
  );
  

  
  export default CorgisWelcomeEmail;
  
  const main = {
    backgroundColor: "#0B062F",
    color: "#ffffff",
    fontFamily:
      '-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen-Sans,Ubuntu,Cantarell,"Helvetica Neue",sans-serif',
  };
  
  const container = {
    margin: "0 auto",
    padding: "20px 0 48px",
  };
  
  const logo = {
    margin: "0 auto",
  };
  
  const paragraph = {
    fontSize: "16px",
    lineHeight: "26px",
  };
  
  const btnContainer = {
    textAlign: "center" as const,
  };
  
  const button = {
    backgroundColor: "#A2FF66",
    borderRadius: "10px 10px 10px 10px",
    color: "#0B062F",
    fontSize: "16px",
    fontWeight: "bold" as const,
    textDecoration: "none",
    textAlign: "center" as const,
    display: "block",
    padding: "12px",
    height: "30px",
  };
  
  const hr = {
    borderColor: "#cccccc",
    margin: "20px 0",
  };
  
  const footer = {
    color: "#8898aa",
    fontSize: "12px",
  };