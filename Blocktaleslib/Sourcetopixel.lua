local PixelGuiLibrary = {}

-- Serviços necessários
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Criar GUI principal
function PixelGuiLibrary:CreateGui(guiName)
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Criar tela principal
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = guiName or "PixelGui"
    screenGui.ResetOnSpawn = false

    -- Botão de abrir/fechar
    local openCloseButton = Instance.new("ImageButton", screenGui)
    openCloseButton.Name = "OpenCloseButton"
    openCloseButton.Size = UDim2.new(0, 80, 0, 80)
    openCloseButton.Position = UDim2.new(0, 10, 1, -100)
    openCloseButton.Image = "rbxassetid://85230808400765" -- Imagem padrão
    openCloseButton.BackgroundTransparency = 1

    -- Frame principal
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = false
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Estilo arredondado
    local uiCorner = Instance.new("UICorner", mainFrame)
    uiCorner.CornerRadius = UDim.new(0, 8)

    -- Título do GUI
    local titleLabel = Instance.new("TextLabel", mainFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = guiName or "Pixel GUI"
    titleLabel.Font = Enum.Font.Arcade
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextStrokeTransparency = 0

    -- Função para abrir/fechar
    local guiOpen = false
    openCloseButton.MouseButton1Click:Connect(function()
        guiOpen = not guiOpen
        mainFrame.Visible = guiOpen
    end)

    -- Função para mudar a imagem do botão
    function PixelGuiLibrary:SetOpenCloseButtonImage(imageId)
        if imageId then
            openCloseButton.Image = "rbxassetid://" .. tostring(imageId)
        else
            warn("ImageId is invalid or nil")
        end
    end

    -- Função para criar botões
    function PixelGuiLibrary:CreateButton(parent, text, position, size, callback)
        local button = Instance.new("TextButton", parent or mainFrame)
        button.Size = size or UDim2.new(0, 120, 0, 40)
        button.Position = position or UDim2.new(0, 20, 0, 60)
        button.Text = text or "Button"
        button.Font = Enum.Font.Arcade
        button.TextSize = 18
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

        -- Estilo arredondado
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        -- Callback do botão
        button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
    end

    -- Função para criar toggles
    function PixelGuiLibrary:CreateToggle(parent, position, callback)
        local toggleFrame = Instance.new("Frame", parent or mainFrame)
        toggleFrame.Size = UDim2.new(0, 80, 0, 30)
        toggleFrame.Position = position or UDim2.new(0, 20, 0, 120)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(200, 60, 60)

        local toggleCorner = Instance.new("UICorner", toggleFrame)
        toggleCorner.CornerRadius = UDim.new(0, 15)

        local toggleBall = Instance.new("Frame", toggleFrame)
        toggleBall.Size = UDim2.new(0, 28, 0, 28)
        toggleBall.Position = UDim2.new(0, 1, 0, 1)
        toggleBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local ballCorner = Instance.new("UICorner", toggleBall)
        ballCorner.CornerRadius = UDim.new(0, 14)

        local toggled = false
        toggleFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                toggled = not toggled

                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local ballTween = TweenService:Create(toggleBall, tweenInfo, {Position = toggled and UDim2.new(1, -29, 0, 1) or UDim2.new(0, 1, 0, 1)})
                local frameTween = TweenService:Create(toggleFrame, tweenInfo, {BackgroundColor3 = toggled and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(200, 60, 60)})

                ballTween:Play()
                frameTween:Play()

                if callback then
                    callback(toggled)
                end
            end
        end)
    end

    return PixelGuiLibrary
end

return PixelGuiLibrary
