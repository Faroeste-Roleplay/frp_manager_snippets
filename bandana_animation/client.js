function addUpgradeTankGameItemToPlayerInventory(itemHash, addAmount)
{
    const b1 = new ArrayBuffer(8 * 12);
    const a2 = new DataView(b1);
    
    const b2 = new ArrayBuffer(8 * 12);
    const a3 = new DataView(b2);

    Citizen.invokeNative("0xCB5D11F9508A928D", 1, a2, a3, itemHash, 1084182731, addAmount, 752097756);
}

addUpgradeTankGameItemToPlayerInventory(-1845241476, 1);
addUpgradeTankGameItemToPlayerInventory(GetHashKey("UPGRADE_STAMINA_TANK_1"), 4);

function js_get_ped_component_at_index ( catNeeded )
{
    const arrayBuffer = new ArrayBuffer(256 * 4);
    const dataView = new DataView(arrayBuffer);

    dataView.setUint32(0, 127, true);

    const arrayBuffer2 = new ArrayBuffer(256 * 4);
    const dataView2 = new DataView(arrayBuffer2);

    dataView2.setUint32(0, 127, true);

    for (let i = 0; i < 40; i++)
    {
        const r = Citizen.invokeNative("0x77BA37622E22023B", PlayerPedId(), i, false, dataView, dataView2, Citizen.returnResultAnyway())
        
        // const arrayOut = new Int32Array(arrayBuffer);
        // const arrayOut2 = new Int32Array(arrayBuffer2);        

        const isMale = IsPedMale(PlayerPedId()) ? 0 : 1;

        let category =  Citizen.invokeNative("0x5FF9A878C3D115B8", r, isMale, true)

        if (category  == catNeeded)
        {
            return r
        }        
    }
}
exports('js_get_ped_component_at_index', js_get_ped_component_at_index)

let withBandana = false
let withMask = true


let lastMask = undefined

RegisterCommand("m",() => 
{    
    const hashMask = js_get_ped_component_at_index( 0x7505EF42 )

    let animDict = ""    
    let updStatus = ""

    const playerPed = PlayerPedId()
    
    if ( hashMask ) {
        animDict = GetHashKey('mask_off_right_hand')
        updStatus = GetHashKey('BASE');

        Citizen.invokeNative("0xAE72E7DF013AAA61", playerPed, hashMask, animDict, 1, 0, -1082130432)        
        
        Citizen.invokeNative("0xD710A5007C2AC539", playerPed, GetHashKey("masks"), 0)
	    Citizen.invokeNative("0xD710A5007C2AC539", playerPed, GetHashKey("masks_large"), 0)

        lastMask = hashMask

        setTimeout(() => {
            Citizen.invokeNative("0xCC8CA3E88256E58F", playerPed, 0, 1, 1, 1, false)            
        }, 700); 
    
    } else {
        animDict = GetHashKey('mask_on_right_hand')
        updStatus = -1829635046
    
        Citizen.invokeNative("0xAE72E7DF013AAA61", playerPed, lastMask, animDict, 1, 0, -1082130432)

        setTimeout(() => {
            Citizen.invokeNative("0xD3A7B003ED343FD9", playerPed, lastMask, true, true, true)    
            lastMask = undefined
        }, 700);
    }
},false);


RegisterCommand("b",() => 
{    

    let animDict = ""    
    let updStatus = ""

    const playerPed = PlayerPedId()

    const hashBandana = js_get_ped_component_at_index( 0x5FC29285 )

    if (hashBandana) 
    {
        if (!withBandana) 
        {            
            animDict = GetHashKey('BANDANA_ON_RIGHT_HAND')
            updStatus = -1829635046

            withBandana = true
        }
        else
        {
            animDict = GetHashKey('BANDANA_OFF_RIGHT_HAND')
            updStatus = GetHashKey('BASE');
            
            withBandana = false
        }
    }

    if (!hashBandana ) return; 


    Citizen.invokeNative("0xAE72E7DF013AAA61", playerPed, hashBandana, animDict, 1, 0, -1082130432)        

    setTimeout(() => {
        Citizen.invokeNative("0x66B957AAC2EAAEAB", playerPed, hashBandana, updStatus, 0, true, 0) // _UPDATE_SHOP_ITEM_WEARABLE_STATE
        Citizen.invokeNative("0xCC8CA3E88256E58F", playerPed, 0, 1, 1, 1, false)            
    }, 700); 

},false);

